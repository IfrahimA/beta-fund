--=====================================
-- Queries for application reports
-- (3 with input and 3 without input for 6 in total)
--
-- ONLY REPORT #1, the Annual Report and its 6 summaries, is ready so far
--
-- The reports are:
-- 1) Annual Report to Donors (with 6 different summaries in addition
--     to the main report - so, 7 queries are needed)
-- 2) Monthly Report
-- 3) Payments Due Report
-- 4) Event Report (needs input to select the event)
-- 5) Class Representative Contact List (needs input to select the class
--     representative)
-- 6) Phonothon Volunteer Contact List (needs input to select the volunteer)
-- 
--=====================================

-- Query to get donors and donations
SELECT * FROM donor JOIN donation USING(donorid);

/* (Report 1) - Annual Report to Donors
 *
 * Gets the name, category, and donor circle for all donors in the current year
 *
 * (The project outline document says to list "all donors by category, year, and donor circle"
 *  but that would get very long if not restricted to a few years at maximum.
 *  So, it only gets donors for the current year)
 */
SELECT
    /* The donation_year is useful for debugging to make sure only 
     * donors from the current year are listed in the report.
     */
    to_char(donation."Date", 'YYYY') AS donation_year,
	donor.donorid,
	donor.lastname,
    donor.firstname,
	category,
	donor.circleid,
	circlename
FROM
	donor,
	donation,
	donor_circle
WHERE
	(donor.donorid = donation.donorid)
	AND (donor.circleid = donor_circle.circleid)
	AND (
		to_char(donation."Date", 'YYYY') = to_char(CURRENT_DATE, 'YYYY')
	) --gets the current year and turns to CHAR for comparison
ORDER BY
	donor.lastname, donor.firstname ASC
;

/* Summaries for Annual Report
 * 6 summaries:
 * - 1) Total from all sources
 * - 2) Total for each class
 * - 3) Percent participation for each class
 * - 4) Total for each donor category
 * - 5) Grand total for each donor circle
 * - 6) Class total for each donor circle
 */

-- (Annual Report Summary 1) Get the total raised from all donors
SELECT
    /* The donation_year is useful for debugging to make sure only 
     * donors from the current year are listed in the report.
     */
    to_char(donation."Date", 'YYYY') AS donation_year,
	COUNT(DISTINCT (donor.donorid)) AS total_donors,
	SUM(amount) AS total_raised_from_all_donors
FROM
	donor
	INNER JOIN donation ON donor.donorid = donation.donorid
WHERE
	--gets the current year and turns to CHAR for comparison
	to_char(donation."Date", 'YYYY') = to_char(CURRENT_DATE, 'YYYY')
GROUP BY donation_year
;

-- (Annual Report Summary 2) Get the total raised per class for each class that had someone donate this year

--Get only donors who have a class year, since some donors did not attend the university
SELECT
    /* The donation_year is useful for debugging to make sure only 
     * donors from the current year are listed in the report.
     */
    to_char(donation."Date", 'YYYY') AS donation_year,
	classyear.classyear AS classyears_with_donors,
	SUM(amount) AS total_raised_per_class
FROM
	donor,
	donation,
	classyear
WHERE
	(donor.donorid = donation.donorid)
	AND (donor.classid = classyear.classid)
	AND
	--gets the current year and turns to CHAR for comparison
	(
		to_char(donation."Date", 'YYYY') = to_char(CURRENT_DATE, 'YYYY')
	)
GROUP BY
	donation_year, classyear.classyear
ORDER BY
	classyear.classyear ASC
;

-- (Annual Report Summary 3) Get the percent participation per class year

/* Select each class that was represented by donors this year and get the percentage of funds the class gave
 * Select the sum of gift money from each class, and divide this by the sum of money received from all class years then multiply by 100 to get a percent
 *  (It accounts for integer division by using '1.0 *')
 * Make sure the percentage calculation only includes gifts from the current year!
 */
SELECT
    /* The donation_year is useful for debugging to make sure only 
     * donors from the current year are listed in the report.
     */
    to_char(donation."Date", 'YYYY') AS donation_year,
	classyear.classyear,
	(
		round((100 * (SUM(donation.amount)) / (
				1.0 * (
					SELECT
						SUM(donation.amount)
					FROM
						donor,
						donation
					WHERE
						(donor.donorid = donation.donorid)
						AND --gets the current year and turns to CHAR for comparison
						(
							TO_CHAR(donation."Date", 'YYYY') = TO_CHAR(CURRENT_DATE, 'YYYY')
						)
				)
			)
		), 1)
	) AS percent_participation_per_class
FROM
	donor,
	donation,
	classyear
WHERE
	(donor.donorid = donation.donorid)
	AND (donor.classid = classyear.classid)
	AND --gets the current year and turns to CHAR for comparison
	(
		to_char(donation."Date", 'YYYY') = to_char(CURRENT_DATE, 'YYYY')
	)
GROUP BY
    donation_year,
	classyear.classyear --aggregate on the class year
ORDER BY
	classyear.classyear ASC --start with the earliest classes
;

-- (Annual Report Summary 4) Get the total raised for each donor category that had donors this year.

SELECT
    /* The donation_year is useful for debugging to make sure only 
     * donors from the current year are listed in the report.
     */
    to_char(donation."Date", 'YYYY') AS donation_year,
	donor.category AS donor_category,
	SUM(amount) AS total_raised_per_category
FROM
	donor
	INNER JOIN donation ON donor.donorid = donation.donorid
WHERE
	--gets the current year and turns to CHAR for comparison
	(
		to_char(donation."Date", 'YYYY') = to_char(CURRENT_DATE, 'YYYY')
	)
GROUP BY
    donation_year,
	donor.category --aggregate on donor category
ORDER BY
	donor.category ASC --sort the categories alphabetically
;

-- (Annual Report Summary 5) Grand total for each donor circle.

SELECT
    /* The donation_year is useful for debugging to make sure only 
     * donors from the current year are listed in the report.
     */
    to_char(donation."Date", 'YYYY') AS donation_year,
	donor_circle.circleid,
	donor_circle.circlename,
	SUM(donation.amount) AS total_raised_per_donor_circle --sum the funds per circle
FROM
	donation,
	donor_circle,
	donor
WHERE
	(donor.donorid = donation.donorid)
	AND (donor.circleid = donor_circle.circleid)
	AND --gets the current year and turns to CHAR for comparison
	(
		to_char(donation."Date", 'YYYY') = to_char(CURRENT_DATE, 'YYYY')
	)
GROUP BY
    donation_year,
	donor_circle.circleid --aggregate on the donor circle recorded for each gift
ORDER BY
	donor_circle.circleid DESC
;

-- (Annual Report Summary 6) Class total for each donor circle.
SELECT
    /* The donation_year is useful for debugging to make sure only 
     * donors from the current year are listed in the report.
     */
    to_char(donation."Date", 'YYYY') AS donation_year,
	classyear.classid,
	classyear.classyear,
	donor_circle.circleid,
	donor_circle.circlename,
	SUM(donation.amount) AS class_total_per_donor_circle
FROM
	donor,
	classyear,
	donation,
	donor_circle
WHERE
	(donor.donorid = donation.donorid)
	AND (donor.classid = classyear.classid)
	AND (donor.circleid = donor_circle.circleid)
	AND --gets the current year and turns to CHAR for comparison
	(
		to_char(donation."Date", 'YYYY') = to_char(CURRENT_DATE, 'YYYY')
	)
GROUP BY
    donation_year,
	classyear.classid,
	classyear.classyear, --aggregate per class id and year
	donor_circle.circleid,
	donor_circle.circlename --and also aggregate per donor circle id and name
ORDER BY
	classyear.classyear DESC, --start with the oldest class years
	donor_circle.circleid DESC --start with the highest donor circle per class year
;

-- (Report 2) - Monthly Report (no input needed since uses current month)

/* Get the sum of gifts for each category this month.
 * Gives totals and percentages of pledges and gifts received for the current month in all donor categories.
 * (The gift_month = CURRENT_MONTH and the GROUP BY donor_category (aggregation on the category) ensure this)
 * (To be hopefully a bit clearer, in here one of the things we're 
 *  getting is the percentage of funds received that each category represents)
 */
SELECT
    /* The donation_year_and_month is useful for debugging to make sure only 
     * donors from the current year are listed in the report.
     */
    to_char(donation."Date", 'YYYY-MM') AS donation_year_and_month,
	donor.category AS donor_category,
	(SUM(donation.amount)) AS total_funds_per_donor_category,
	(
		round((
			--divide the sum of donation money per category by the total funds received this month
			(SUM(donation.amount)) / (
				1.0 * (
					SELECT
						SUM(donation.amount)
					FROM
						donation
					WHERE
						--gets the current month and turns to CHAR for comparison
						(
							to_char(donation."Date", 'YYYY-MM') = to_char(CURRENT_DATE, 'YYYY-MM')
						)
				)
			)
		) * 100, 1)
        --the above times 100 & rounded to one decimal place to get the percentage for this donor category
	) AS percentage_of_funds_per_donor_category
FROM
	donation,
	donor
WHERE
	(donation.donorid = donor.donorid)
	AND --gets the current month and turns to CHAR for comparison
	(
		to_char(donation."Date", 'MM') = to_char(CURRENT_DATE, 'MM')
	)
GROUP BY
    donation_year_and_month,
	donor.category
ORDER BY
	percentage_of_funds_per_donor_category DESC
;