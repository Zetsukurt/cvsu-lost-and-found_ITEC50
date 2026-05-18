BEGIN; -- Starts a safe transaction block. If a column name differs, it rolls back cleanly without breaking anything.

-- ========================================================================
-- 1. OPTIMIZATIONS FOR TABLE: PUBLIC.CLAIMS
-- ========================================================================

-- Issue #1: "Allow claimants to update their own claims"
DROP POLICY IF EXISTS "Allow claimants to update their own claims" ON public.claims;
CREATE POLICY "Allow claimants to update their own claims" ON public.claims
    FOR UPDATE TO authenticated USING ((SELECT auth.uid()) = claimer_id);

-- Issue #3: "Allow finders to view claims on their items"
DROP POLICY IF EXISTS "Allow finders to view claims on their items" ON public.claims;
CREATE POLICY "Allow finders to view claims on their items" ON public.claims
    FOR SELECT TO authenticated USING (
        item_id IN (SELECT id FROM public.items WHERE reporter_id = (SELECT auth.uid()))
    );

-- Issue #4: "Allow finders to update claims on their items"
DROP POLICY IF EXISTS "Allow finders to update claims on their items" ON public.claims;
CREATE POLICY "Allow finders to update claims on their items" ON public.claims
    FOR UPDATE TO authenticated USING (
        item_id IN (SELECT id FROM public.items WHERE reporter_id = (SELECT auth.uid()))
    );


-- ========================================================================
-- 2. OPTIMIZATIONS FOR TABLE: PUBLIC.ITEMS
-- ========================================================================

-- Issue #2: "Users can update their own reports"
DROP POLICY IF EXISTS "Users can update their own reports" ON public.items;
CREATE POLICY "Users can update their own reports" ON public.items
    FOR UPDATE TO authenticated USING ((SELECT auth.uid()) = reporter_id);

-- Issue #5: "Allow finders to update their own items"
DROP POLICY IF EXISTS "Allow finders to update their own items" ON public.items;
CREATE POLICY "Allow finders to update their own items" ON public.items
    FOR UPDATE TO authenticated USING ((SELECT auth.uid()) = reporter_id);

COMMIT; -- Securely executes and commits all 5 optimization updates simultaneously if no errors occur!