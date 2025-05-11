!> @file FIXME this is not appearing in the generated documentation
!> @brief a funny program that computes all the occurences of friday 13th that coincide with full moon
!>
program badluk
   use ch1, only: julday, flmoon
   implicit none
   integer :: ic, icon, idwk, ifrac, im, iyyy, jd, jday, n
   real :: frac
   real, parameter :: TIMZON = (-5./24.)
   integer :: iybeg = 1900, iyend = 2050

   write (*,'(1x,a,i5,a,i5)') 'Full moons on Friday 13th from', iybeg, ' to', iyend

   ! loop over each year and each month and check if the 13th is friday
   do iyyy = iybeg, iyend
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
1           call flmoon(n, 2, jd, frac)
            ifrac = nint(24.*(frac + TIMZON))
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
               write (*,'(/1x,i2,a,i2,a,i4)') im,'/',13,'/',iyyy
               write (*,'(1x,a,i2,a)') 'Full moon ', ifrac, ' hrs after midnight (EST).'
               goto 2
            else
               ic = isign(1,jday-jd)
               if (ic.eq.-icon) goto 2 ! another break, case of no match
               icon = ic
               n = n + ic
            endif
            goto 1
2           continue
         endif
      enddo
   enddo
end program badluk
! those goto are really dangerous!, I just spend almost 30 minites to figure out that 1 should had been placed in the call of flmoon
! and not in the call of julday, that led to an infinite loop
