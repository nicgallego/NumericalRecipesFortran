!> @brief implementation, see julday interface in module ch1

function julday(mm,id,iyyy) result(jd)
   implicit none
   integer, intent(in) :: mm
   integer, intent(in) :: id
   integer, intent(in) :: iyyy
   integer :: jd

   ! intern variables and constants
   integer, parameter :: IGREG = 15+31*(10+12*1582)
   integer ja, jm, jy

   ! executable part
   jd = 0 ! avoid warning on unitialized
   jy = iyyy
   if (jy.eq.0) then
      write(6,*) '[error:] julday, ther is no year zero'
      return
   endif
   if (jy.lt.0) jy=jy+1
   if (mm.gt.2) then
      jm=mm+1
   else
      jy=jy-1
      jm=mm+13
   endif
   jd=int(365.25*jy)+int(30.6001*jm)+id+1720995
   if (id+31*(mm+12*iyyy).ge.IGREG) then   ! Test to change to Gregorian Calendar
      ja=int(0.01*jy)
      jd=jd+2-ja+int(0.25*ja)
   endif
   return
end function julday
