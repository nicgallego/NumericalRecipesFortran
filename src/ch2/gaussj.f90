!> @brief implementation of gauus jordan routine
!>
subroutine gaussj(A,n,np,B,m,mp,ok)
   implicit none
   real, intent(inout), dimension(:,:) :: A, B
   integer, intent(in) :: m, n, mp, np
   logical, intent(out) :: ok

   !> internal variables
   integer i, icol, irow, j, k, l, ll
   real big, dum, pivinv
   integer indxc(n), indxr(n), ipiv(n)

   ok = .true.
   !> check dimensions are correct
   if ( &
      (size(A, dim=1) .ne. n) .or. &
      (size(A, dim=2) .ne. n) .or. &
      (size(B, dim=1) .ne. n) .or. &
      (size(B, dim=2) .ne. m) &
      ) then
      print *, 'wrong dimensions of input matrices'
      ok = .false.
      return
   end if

   do j = 1, n       !> internal bookkeeping
      ipiv(j) = 0
   end do

   do i = 1, n       !> main loop over columns to be reduced
      big = 0.
      do j = 1, n    !> outer loop to search for the pivot element
         if (ipiv(j).ne.1) then
            do k = 1, n
               if (ipiv(k).eq.0) then
                  if (abs(A(j,k)).ge.big) then
                     big = abs(A(j,k))
                     irow = j
                     icol = k
                  end if
               else if (ipiv(k).gt.1) then
                  print *, 'singular matrix in gaussj, detected while looking for a pivot'
                  ok = .false.
                  return
               end if
            end do
         end if
      end do !> outer loop

      ipiv(icol) = ipiv(icol) + 1
      !> we now have a pivot element, so we interchange rows, if needed to put the pivot
      !> element on the diagonal. The columbs are not physically interchanged, only relabeled:
      !> indxc(i), the column of the ith pivot element, is the ith colombt that is reduced, while
      !> indxr(i), is the row in which that pivot element was originally located.
      !> if indxr(i) != indxc(i), the ir and implied column interchange.
      !> With this form of bookkeeping, the solution b's will end up in the correct order,
      !> and the inverse matrix will be scrambled by columns.
      if (irow.ne.icol) then
         do l = 1, n       !> carefull, index l, not literal 1
            dum = A(irow,l)
            A(irow,l) = A(icol,l)
            A(icol,l) = dum
         end do
         do l = 1, m       !> scrable B in the same way
            dum = B(irow,l)
            B(irow,l) = B(icol,l)
            B(icol,l) = dum
         end do
      end if

      !> now we are ready to devide by the pivot element int irow, icol
      indxr(i) = irow
      indxc(i) = icol
      if ( abs(A(icol,icol)) .lt. tiny(0.0) ) then
         print *, 'singular matrix in gaussj, detected while attemping to divide by a zero pivot'
         ok = .false.
         return
      end if
      pivinv = 1. / A(icol,icol)
      A(icol,icol) = 1.
      do l = 1, n
         A(icol,l) = A(icol,l) * pivinv
      end do
      do l = 1, m
         B(icol,l) = B(icol,l) * pivinv
      end do

      !> next reduce the rows
      do ll = 1, n
         if (ll.ne.icol) then   !> fol all except the pivot
            dum = A(ll,icol)
            A(ll,icol) = 0.
            do l = 1, n
               A(ll, l) = A(ll, l) - A(icol, l)*dum
            end do
            do l = 1, m
               B(ll, l) = B(ll, l) - B(icol, l)*dum
            end do
         end if
      end do
   end do !> main loop

   !> it only remains to unscrable the solution in view of the column interchanges.
   !> we do this byt interchanging the pairs of columns in reverse order that the
   !> permutations was build up
   do l = n, 1, -1
      if (indxr(l) .ne. indxc(l)) then
         do k = 1, n
            dum = A(k, indxr(l))
            A(k, indxr(l)) = A(k, indxc(l))
            A(k, indxc(l)) = dum
         end do
      end if
   end do

   !> and we are done
   return
end subroutine gaussj
