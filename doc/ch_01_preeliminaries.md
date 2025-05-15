# 1. Preeliminaries {#ch_01_preeliminaries}

This chapter was introductory and used funny examples with dates to introduce programming in Fortran. @todo My implementation of the `flmoon` or `badluk` have at least one bug. Or the data I am comparing to is wrong. I may come back later and fix it. I left for now the test fail. Will break when the bug is corrected.

At the end was a short discussion about stability of algorithms a that I coded and bencharked.

## Example of an unstable algorithm

The sequence of powers of the number known as the 'gold ratio' 
\f[
    \phi \equiv \frac{\sqrt{5} - 1}{2} \approx 0.61803398,
\f]

satisfy the recurrence rule
\f[ 
    \phi^{n+1} = \phi^{n-1} - \phi^{n},
\f]

which can be verified by induction. Start from \f$ \phi^0 = 1 \f$ and \f$ \phi^1 = \phi \f$. Then \f$ \phi^2 = \left( \frac{\sqrt{5} - 1}{2} \right)^2 \f$. Expanding the binomial and rearranging terms \f$ \phi^2 = 1 - \frac{\sqrt{5} - 1 }{2} = \phi^0 - \phi^2 \f$. Using the induction assumption that \f$ \phi^n = \phi^{n-2} - \phi^{n-1} \f$ holds, we perform the induction step \f$ n \leadsto n + 1 \f$ by multipliying both sides of the assumption equality by \f$ \phi \f$  and then add the exponents of the products of equal bases to arrive to the recursion expression.

In theory works, in practice this computation is unstable, that means rounding error gets amplified. It is stated that the recursion also converges numerically to 
\f[
    -\frac{\sqrt{5} + 1}{2}.
\f]

Why? No prove nor further hint is given but a practical observation that for a 32-bit real representation, after \f$ n > 16 \f$, the terms are already down to 1e-4 and the round-off error dominates. I compute the reference value `p_ref` using the intrinsic power operator, `p_mult` refers to a recursive multiplication, and `p_rec` to the recursion above. See benchmark program `ps_benchmark` for details. Here my table of the first few terms of the sequence, computed with 32 bit real variables:

 |      k    |     p_ref(k)       |         p_mult(k)        |      p_rec(k)    |
 | ----------- | -------------------- | -------------------------- | ------------------ |
 |           1 |  0.618034005     |  0.618034005     |  0.618034005     |
 |           2 |  0.381966025     |  0.381966025     |  0.381966025     |
 |           3 |  0.236067995     |  0.236067995     |  0.236067981     |
 |           4 |  0.145898044     |  0.145898044     |  0.145898044     |
 |           5 |   9.01699513E-02 |   9.01699513E-02 |   9.01699364E-02 |
 |           6 |   5.57280965E-02 |   5.57280965E-02 |   5.57281077E-02 |
 |           7 |   3.44418585E-02 |   3.44418585E-02 |   3.44418287E-02 |
 |           8 |   2.12862398E-02 |   2.12862398E-02 |   2.12862790E-02 |
 |           9 |   1.31556196E-02 |   1.31556196E-02 |   1.31555498E-02 |
 |          10 |   8.13062023E-03 |   8.13062023E-03 |   8.13072920E-03 |
 |          11 |   5.02499985E-03 |   5.02499985E-03 |   5.02482057E-03 |
 |          12 |   3.10562085E-03 |   3.10562085E-03 |   3.10590863E-03 |
 |          13 |   1.91937923E-03 |   1.91937934E-03 |   1.91891193E-03 |
 |          14 |   1.18624163E-03 |   1.18624175E-03 |   1.18699670E-03 |
 |          15 |   7.33137655E-04 |   7.33137713E-04 |   7.31915236E-04 |
 |          16 |   4.53104003E-04 |   4.53104032E-04 |   4.55081463E-04 |
 |          17 |   2.80033681E-04 |   2.80033710E-04 |   2.76833773E-04 |
 |          18 |   1.73070337E-04 |   1.73070352E-04 |   1.78247690E-04 |
 |          19 |   1.06963351E-04 |   1.06963365E-04 |   9.85860825E-05 |
 |          20 |   6.61069862E-05 |   6.61070007E-05 |   7.96616077E-05 |
 |          21 |   4.08563646E-05 |   4.08563756E-05 |   1.89244747E-05 |
 |          22 |   2.52506234E-05 |   2.52506288E-05 |   6.07371330E-05 |
 |          23 |   1.56057431E-05 |   1.56057467E-05 |  -4.18126583E-05 |
 |          24 |   9.64488027E-06 |   9.64488208E-06 |   1.02549791E-04 |
 |          25 |   5.96086375E-06 |   5.96086511E-06 |  -1.44362450E-04 |
 |          26 |   3.68401652E-06 |   3.68401743E-06 |   2.46912241E-04 |
 |          27 |   2.27684745E-06 |   2.27684814E-06 |  -3.91274691E-04 |
 |          28 |   1.40716929E-06 |   1.40716952E-06 |   6.38186932E-04 |
 |          29 |   8.69678388E-07 |   8.69678615E-07 |  -1.02946162E-03 |
 |          30 |   5.37490848E-07 |   5.37490962E-07 |   1.66764855E-03 |
 |          31 |   3.32187597E-07 |   3.32187682E-07 |  -2.69711018E-03 |
 |          32 |   2.05303238E-07 |   2.05303280E-07 |   4.36475873E-03 |
 |          33 |   1.26884387E-07 |   1.26884402E-07 |  -7.06186891E-03 |
 |          34 |   7.84188643E-08 |   7.84188714E-08 |   1.14266276E-02 |
 |          35 |   4.84655232E-08 |   4.84655303E-08 |  -1.84884965E-02 |
 |          36 |   2.99533411E-08 |   2.99533447E-08 |   2.99151242E-02 |
 |          37 |   1.85121838E-08 |   1.85121856E-08 |  -4.84036207E-02 |
 |          38 |   1.14411582E-08 |   1.14411600E-08 |   7.83187449E-02 |
 |          39 |   7.07102510E-09 |   7.07102599E-09 | -0.126722366     |
 |          40 |   4.37013403E-09 |   4.37013448E-09 |  0.205041111     |
 |          41 |   2.70089129E-09 |   2.70089173E-09 | -0.331763476     |
 |          42 |   1.66924263E-09 |   1.66924297E-09 |  0.536804557     |
 |          43 |   1.03164877E-09 |   1.03164888E-09 | -0.868568063     |
 |          44 |   6.37594033E-10 |   6.37594089E-10 |   1.40537262     |
 |          45 |   3.94054761E-10 |   3.94054817E-10 |  -2.27394056     |
 |          46 |   2.43539244E-10 |   2.43539272E-10 |   3.67931318     |
 |          47 |   1.50515531E-10 |   1.50515558E-10 |  -5.95325375     |
 |          48 |   9.30237207E-11 |   9.30237345E-11 |   9.63256645     |
 |          49 |   5.74918203E-11 |   5.74918307E-11 |  -15.5858202     |
 |          50 |   3.55319003E-11 |   3.55319073E-11 |   25.2183876     |
 |          51 |   2.19599217E-11 |   2.19599269E-11 |  -40.8042068     |
 |          52 |   1.35719786E-11 |   1.35719812E-11 |   66.0225983     |
 |          53 |   8.38794399E-12 |   8.38794572E-12 |  -106.826805     |
 |          54 |   5.18403463E-12 |   5.18403549E-12 |   172.849396     |
 |          55 |   3.20390958E-12 |   3.20391023E-12 |  -279.676208     |
 |          56 |   1.98012505E-12 |   1.98012548E-12 |   452.525604     |
 |          57 |   1.22378464E-12 |   1.22378485E-12 |  -732.201782     |
 |          58 |   7.56340520E-13 |   7.56340628E-13 |   1184.72742     |
 |          59 |   4.67444171E-13 |   4.67444226E-13 |  -1916.92920     |
 |          60 |   2.88896402E-13 |   2.88896430E-13 |   3101.65674     |
 |          61 |   1.78547783E-13 |   1.78547823E-13 |  -5018.58594     |
 |          62 |   1.10348613E-13 |   1.10348627E-13 |   8120.24268     |
 |          63 |   6.81991898E-14 |   6.81992033E-14 |  -13138.8281     |
 |          64 |   4.21494199E-14 |   4.21494267E-14 |   21259.0703     |

 Error statistics of algorithms with respect to reference values:

 |        | p\_mult error    |    p\_rec error  |
 | ------ | ---------------- | ---------------- |
 | min    |   0.00000000     |   0.00000000     |
 | avg    |   6.53780762E-12 |   869.640137     |
 | max    |   1.16415322E-10 |   21259.0703     |

This shows that in my implementation the recurrence blows up, oscillating wildely alternating signs unbounded.

@todo Clarify by the recurrence of powers of 'golden mean' diverge in my implementation. How to prove or disprove the conjecture?
