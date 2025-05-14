module ch1
   use date_utils, only: dates_list, date_node, date
   implicit none
   public
   ! this nasty includes require saving this file each time one of the included files gets updated.

   !> @brief inverse funtion of julian day
   !>
   !> @param[in] julian a julian day number, see by julday routine for details
   !> @param[out] mm month 01 january to 12 december
   !> @param[out] id integer day, 1 to 31 at most
   !> @param[out] iyyy integer year, usually a 4 digit number

   interface
      subroutine caldat(julian, mm, id, iyyy)
         integer, intent(in) :: julian
         integer, intent(out) :: mm, id, iyyy
      end subroutine caldat
   end interface

   !> @brief converts a date to Julian number
   !>
   !> @details The returned julday begins at noon of the specified calendar day.
   !>
   !> @param[in] mm month 01 January ... 12 December
   !> @param[in] id day of the month. 1 to 31 at most
   !> @param[in] iyyy year -1 is a B.C and the next is +1, 1 A.D. There is no year 0
   !>
   !> @return integer Julian day
   !>
   !> @details Example: Julian Day 2440000 began at noon of May 23, 1968.
   !> Additionally jd+1 module 7 gives the day of the week. 0 Sunday, 1 Monday, ... 6 Saturday.

   interface
      function julday(mm,id,iyyy) result(jd)
         integer, intent(in) :: mm
         integer, intent(in) :: id
         integer, intent(in) :: iyyy
         integer :: jd
      end function
   end interface

   !! @brief Calculates the phases of the moon
   !!
   !! To be precise the nth requested phase of the moon since january 1900 and retuns the data encoded
   !! as a Julian number and a fraction to be added to it.
   !!
   !! Greenwich mean time is assumed.
   !!
   !! [astronomical-formulae](https://literature.hpcalc.org/community/astronomical-formulae.pdf)
   !!
   !> @param[in] n integer representing the nth occurence of nph phase since January 1900.
   !> @param[in] nph code for desired phase: 0 new moon, 1 first quarter, 2 full moon, 3 last quarter
   !> @param[out] jd Julian Day Number
   !> @param[out] frac fractional part of the day to be added to jd

   interface
      subroutine flmoon(n,nph,jd,frac)
         integer, intent(in) :: n, nph
         integer, intent(out) :: jd
         real, intent(out) :: frac
      end subroutine flmoon
   end interface

contains


   !> @brief bootstrap function from the original program to make it testable
   !> @param[in] from_year year from which the search starts, included in the interval
   !> @param[in] to_year year until which the search ends, included in the interval
   !> @param[in] timezone integer positive or negative representing the time zone relative to Greenwish meridiant (UTC)
   !> @return dates dates, stored in a linked list, refer to date utils module.

   function badluck(from_year, to_year, timezone) result(dates)
      integer, intent(in) :: from_year, to_year, timezone
      type(dates_list)  :: dates

      integer :: ic, icon, idwk, ifrac, im, iyyy, jd, jday, n
      real :: frac
      real :: tz_frac

      type(date_node), pointer :: new_date

      tz_frac = timezone / 24.
      ! loop over each year and each month and check if the 13th is friday
      do iyyy = from_year, to_year
         do im = 1, 12
            jday = julday(im, 13, iyyy)
            idwk = mod(jday+1, 7)
            if (idwk.eq.5) then
               n = 12.37*(iyyy - 1900 + (im - 0.5)/12.) ! truncation, better explict?
               ! first approximation to how many full moons since 1900
               ! n is feed into flmoon routine and the adjusted up or and down until we can determine if the 13th was or not a full
               ! moon.
               ! icon signals the direction of the adjustment
               icon = 0
1              call flmoon(n, 2, jd, frac)
               ifrac = nint(24.*(frac + tz_frac))
               if (ifrac.lt.0) then
                  jd = jd - 1
                  ifrac = ifrac + 24
               endif
               if (ifrac.gt.12) then
                  jd = jd + 1
                  ifrac = ifrac - 12
               else
                  ifrac = ifrac + 12
               endif
               if (jd.eq.jday) then ! did we hit our target day?
                  allocate (new_date)
                  new_date%m_date = date(month=im, day=13, year=iyyy, hour=ifrac)
                  new_date%next => null()
                  call dates%push_back(new_date)
                  goto 2
               else
                  ic = isign(1,jday-jd)
                  if (ic.eq.-icon) goto 2 ! another break, case of no match
                  icon = ic
                  n = n + ic
               endif
               goto 1
2              continue
            end if
         end do
      end do

   end function badluck

end module ch1
