module ch2_mod
   implicit none

   public

   interface
      !> @brief Gauss Jordan algorithm for solution of linear systems of equations 
      !>
      subroutine gaussj(A,n,np,B,m,mp)
         real, intent(inout), dimension(:,:) :: A, B
         integer, intent(in) :: m, n, mp, np
      end subroutine gaussj
   end interface

end module ch2_mod
