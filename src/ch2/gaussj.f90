!> @brief implementation of gauus jordan routine
!>
subroutine gaussj(A,n,np,B,m,mp)
   implicit none
   real, intent(inout), dimension(:,:) :: A, B
   integer, intent(in) :: m, n, mp, np

   A(1,1) = A(1,1) + 1.0 
end subroutine gaussj
