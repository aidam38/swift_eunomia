#!/usr/bin/awk -f

BEGIN{
  rho_PB = 4300.;	# kg/m^3
  G = 6.67e-11;		# SI
  pi = 3.1415926535;
}
{
  D = $1;
  V = D**3;
  V_PB += V;
}
(NR==1){
  D_LF = $1;
}
END{
  D_PB = V_PB**(1./3.);
  LF_PB = (D_LF**3)/V_PB;

  R_PB = D_PB*1.e3/2.;
  v_esc = sqrt(8./3.*pi*G*rho_PB) * R_PB;

  print "D_PB = " D_PB " km";
  print "LF/PB = " LF_PB " (Largest Fragment/Parent Body mass ratio)";
  print "v_esc = " v_esc " m/s = ", v_esc/1.e3, " km/s";
}

