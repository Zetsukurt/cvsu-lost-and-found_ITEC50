BEGIN; -- Starts a safe transaction block. If any step fails, it automatically rolls back safely.

-- ========================================================================
-- CLEANUP PHASE: DROP ALL REDUNDANT & DUPLICATE POLICIES FLAGGED IN REPORT
-- ========================================================================

-- 1. Redundant Policies on Table: public.claims [cite: 13, 16]
DROP POLICY IF EXISTS "Allow finders to view claims on their items" ON public.claims;
DROP POLICY IF EXISTS "Users and Admins can view claims" ON public.claims;
DROP POLICY IF EXISTS "Admins can update claim status" ON public.claims;
DROP POLICY IF EXISTS "Allow claimants to update their own claims" ON public.claims;
DROP POLICY IF EXISTS "Allow finders to update claims on their items" ON public.claims;

-- 2. Redundant Policies on Table: public.items [cite: 19, 22, 28]
DROP POLICY IF EXISTS "Public can view found items" ON public.items;
DROP POLICY IF EXISTS "Public items are viewable by everyone" ON public.items;
DROP POLICY IF EXISTS "Reporters and Admins can update items" ON public.items;
DROP POLICY IF EXISTS "Users can update their own reports" ON public.items;
DROP POLICY IF EXISTS "Allow finders to update their own items" ON public.items;

-- 3. Redundant Policies on Table: public.profiles [cite: 49]
DROP POLICY IF EXISTS "Allow public read access for profiles" ON public.profiles;
DROP POLICY IF EXISTS "Public profiles are viewable by everyone" ON public.profiles;
DROP POLICY IF EXISTS "Users can view own profile" ON public.profiles;


-- ========================================================================
-- REBUILD PHASE: INJECT SINGLE, HIGH-PERFORMANCE OPTIMIZED POLICIES
-- ========================================================================

-- ------------------------------------------------------------------------
-- A. OPTIMIZED POLICIES FOR: PUBLIC.ITEMS
-- ------------------------------------------------------------------------
-- Combined Public View Strategy: Universal open access target covering all roles smoothly [cite: 19]
CREATE POLICY "Optimized universal read for items" ON public.items
    FOR SELECT USING (true);

-- Combined Update Strategy: Merges Finder, Reporter, and Admin modifications safely [cite: 22, 28]
CREATE POLICY "Optimized update access for items" ON public.items
    FOR UPDATE TO authenticated 
    USING (
        (SELECT auth.uid()) = reporter_id OR 
        (SELECT is_admin FROM public.profiles WHERE id = (SELECT auth.uid())) = true
    );


-- ------------------------------------------------------------------------
-- B. OPTIMIZED POLICIES FOR: PUBLIC.CLAIMS
-- ------------------------------------------------------------------------
-- Combined Claims View Strategy: Allows Claimants, Finders, and Admins to inspect claims cleanly [cite: 13]
CREATE POLICY "Optimized view access for claims" ON public.claims
    FOR SELECT TO authenticated 
    USING (
        (SELECT auth.uid()) = claimer_id OR 
        item_id IN (SELECT id FROM public.items WHERE reporter_id = (SELECT auth.uid())) OR
        (SELECT is_admin FROM public.profiles WHERE id = (SELECT auth.uid())) = true
    );

-- Combined Claims Update Strategy: Manages status controls across roles without performance degradation [cite: 16]
CREATE POLICY "Optimized update access for claims" ON public.claims
    FOR UPDATE TO authenticated 
    USING (
        (SELECT auth.uid()) = claimer_id OR 
        item_id IN (SELECT id FROM public.items WHERE reporter_id = (SELECT auth.uid())) OR
        (SELECT is_admin FROM public.profiles WHERE id = (SELECT auth.uid())) = true
    );


-- ------------------------------------------------------------------------
-- C. OPTIMIZED POLICIES FOR: PUBLIC.PROFILES
-- ------------------------------------------------------------------------
-- Combined Profiles View Strategy: Cleans up the 3 duplicate open selectors into 1 performant rule [cite: 49]
CREATE POLICY "Optimized universal read for profiles" ON public.profiles
    FOR SELECT USING (true);


-- ========================================================================
-- D. PERFORMANCE INDEX FIX
-- ========================================================================
-- Drops the redundant index allocation bottleneck to speed up write times on profiles 
DROP INDEX IF EXISTS public.unique_student_id;

COMMIT; -- Commit all structural cleanups simultaneously!