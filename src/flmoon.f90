!
!! @brief Calculates the phases of the moon
!!
!! To be precise the nth requested phase of the moon since january 1900 and retuns the data encoded
!! as a Julian number and a fraction to be added to it.
!!
!! Greenwich mean time is assumed.
!!
!! https://literature.hpcalc.org/community/astronomical-formulae.pdf
!!
!> @param[in] n integer representing the nth occurence of nph phase since January 1900.
!> @param[in] nph code for desired phase: 0 new moon, 1 first quarter, 2 full moon, 3 last quarter
!> @param[out] jd Julian Day Number
!> @param[out] frac fractional part of the day to be added to jd 
!
subroutine flmoon(n,nph,jd,frac)
        implicit none
        integer, intent(in) :: n,nph
        integer, intent(out) :: jd
        real, intent(out) :: frac
        real, parameter :: RAD=3.14159265/180.

        integer i
        real am, as, c, t, t2, xtra
        c=n+nph/4.
        t=c/1236.85
        t2=t**2
        as=359.2242+29.105356*c ! no way to understand the algorithm... nor expected, but works. See unit test
        am=306.0253+358.816918*c + 0.010730*t2
        jd=2415020+28*n+7*nph
        xtra=0.75933+1.53058868*c+(1.178e-4 - 1.55e-7*t)*t2
        if(nph.eq.0.or.nph.eq.2)then
                xtra=xtra+(0.1734 - 3.93e-4*t)*sin(RAD*as) - 0.4068*sin(RAD*am)        
        else if(nph.eq.1.or.nph.eq.3)then
                xtra=xtra+(0.1721 - 4.e-4*t)*sin(RAD*as) - 0.6280*sin(RAD*am)
        else
                write(6,*) '[error:] nph = ', nph, ' is unknown in flmoon'        
                return
        endif
        if(xtra.ge.0)then
                i=int(xtra)
        else
                i=int(xtra-1.)
        endif
        jd=jd+i
        frac=xtra-i
        return
end subroutine
