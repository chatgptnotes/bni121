-- Revert script for the DevOps stage-5 changes + seed data + Tarun.
-- Each section is independent. Run only the sections you want to undo.
-- Editor: https://supabase.com/dashboard/project/bvaefzcsgtgqwftczixb/sql/new

-- ─────────────────────────────────────────────────────────────────────────────
-- SECTION A. Drop the 480 seeded work items + 7 seeded projects.
-- This is the most-likely "I want my old state back" case.
-- The cascade on dev_work_items.project_id removes all work items
-- referencing these projects in one shot. Your original 3 projects
-- (p_bni, p_drmhope, p_general) and their items are NOT touched.
-- ─────────────────────────────────────────────────────────────────────────────
delete from dev_projects where id in (
  'p_healthcare', 'p_compliance', 'p_scada',
  'p_ai', 'p_crm', 'p_sales', 'p_mobile_other'
);
-- Verify:
--   select count(*) from dev_work_items;
--   select id, name from dev_projects order by name;

-- ─────────────────────────────────────────────────────────────────────────────
-- SECTION B. Drop the new tables added by migrations_devops_stage5.sql.
-- After running this, /bni/dev-calendar.html and /bni/dev-retro.html will
-- show errors when you open them (they read from these tables).
-- Skip this section if you want to keep the Calendar and Retro features.
-- ─────────────────────────────────────────────────────────────────────────────
-- drop table if exists dev_retros;
-- drop table if exists dev_resource_leaves;

-- ─────────────────────────────────────────────────────────────────────────────
-- SECTION C. Remove Tarun from the developers table.
-- Only run this if you do not want Tarun in the assignee dropdowns.
-- ─────────────────────────────────────────────────────────────────────────────
-- delete from developers where name = 'Tarun';

-- ─────────────────────────────────────────────────────────────────────────────
-- Sections B and C are commented out so SECTION A runs alone by default.
-- Uncomment them if you want a fuller undo.
-- ─────────────────────────────────────────────────────────────────────────────
