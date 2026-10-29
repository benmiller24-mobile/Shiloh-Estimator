-- =====================================================================
-- Shiloh Estimator — extend profile guard  (2026-10-29)
-- Run once in Supabase → SQL Editor for project kicfzapvaxgaorgwnpgs.
-- Safe to re-run.
--
-- The existing profiles_role_guard stops role changes, but a dealer can
-- still reassign their own dealer_id, and the guard also blocked admins
-- editing roles from the SQL editor (no JWT → is_admin() false). This
-- replaces it with the same guard used on Eclipse.
-- =====================================================================

create or replace function public.prevent_role_escalation()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  if auth.uid() is not null and not public.is_admin() then
    if new.role is distinct from old.role then
      raise exception 'Only admins can change profile roles' using errcode = '42501';
    end if;
    if new.dealer_id is distinct from old.dealer_id then
      raise exception 'Only admins can change dealer assignment' using errcode = '42501';
    end if;
    if new.email is distinct from old.email then
      raise exception 'Email is managed by authentication' using errcode = '42501';
    end if;
  end if;
  return new;
end;
$$;

create or replace function public.guard_profile_insert()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  if auth.uid() is not null and not public.is_admin() then
    new.role := 'pending';
    new.dealer_id := null;
  end if;
  return new;
end;
$$;

drop trigger if exists profiles_insert_guard on public.profiles;
create trigger profiles_insert_guard
  before insert on public.profiles
  for each row execute function public.guard_profile_insert();

-- Supabase security-advisor hygiene
alter function public.handle_new_user() set search_path = public;
alter function public.update_updated_at() set search_path = public;
alter function public.set_updated_at() set search_path = public;
revoke execute on function public.handle_new_user() from public, anon, authenticated;
revoke execute on function public.prevent_role_escalation() from public, anon, authenticated;
revoke execute on function public.guard_profile_insert() from public, anon, authenticated;

-- shared_projects is a SECURITY DEFINER view (advisor ERROR) readable by anon:
-- it lists every share-enabled project WITH its share_token and dealer_total,
-- which defeats the point of an unguessable share link. Nothing in this repo
-- uses it (0 rows today). Make it run with the caller's rights and close it
-- to anonymous reads; a share page should look up ONE token via an RPC.
alter view public.shared_projects set (security_invoker = true);
revoke select on public.shared_projects from anon;
