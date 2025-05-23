module ch2_mod
   implicit none

   public

   interface
      !> @brief Gauss Jordan algorithm for solution of linear systems of equations
      !>
      !> \f$ A x = b \f$
      !>
      !> @param[inout] A equations matrix, n x n. On return will hold the inverse of A.
      !> @param[in] n number of equations and variables
      !> @param[in] np physical number of equations... (obsolete, assuming n=np)
      !> @param[inout] B matrix of right hand sides, m of them. On return will contain the solutions.
      !> @param[in] m number of right hand sides
      !> @param[in] mp physical numebr of right hand sides... (obsolete, assuming m=mp)
      !>
      subroutine gaussj(A,n,np,B,m,mp)
         real, intent(inout), dimension(:,:) :: A, B
         integer, intent(in) :: m, n, mp, np
      end subroutine gaussj
   end interface

end module ch2_mod
