#include <math.h>
#include "lpm_var.def"

int lpm_lumult
 (int m, /* �᫮ ��࠭�祭�� */
  int n, /* �᫮ ��६����� �८��.����� */
  lpm_num l /* ����� ������ �८��.����� */
 )
/* ���⨯����⨢��� ࠧ������� ����᭮� ������ */
 {int i, i1, i2, i21, ir, is, j, jj, j2, jis;
  int k, k1, il, nk, nr, it, itb, iun, nml;
  int  *pnum;
  lpm_num l0, l1, ls, nuel, r1, rs;
  lpm_pibi pibi;
  double u;
  float b2, b3, z, zm, xm;
#ifdef WINDOWS
  int IOstatus;

  if (!lpm_WND)
ERR_RET (lpm_to_wnd ());
  lpm_ncol = (int *) GlobalLock (hLpm_ncol);
  lpm_nrow = (int *) GlobalLock (hLpm_nrow);
#endif
  for (i = 0; i < m; i++)
   {lpm_ncol [i] = 0;
    lpm_nrow [i] = 0;
   }
  it  = 0;  /* ���稪 ������⮢ ��㣮�쭮� ������ */
  il  = 0;  /* ���稪 ������� �⮫�殢 */
  itb = 0;  /* ���稪 ������⮢ ����᭮� ������ */
#ifdef WINDOWS
  lpm_iacol = (lpm_num *) GlobalLock (hLpm_iacol);
#endif
  for (i = 0; i < m; i++)
   {ir = lpm_ibase [i];
/*    if (ir == 0)    ��ࠢ���� 24.04.96 */
    if (ir == 0 || ir == -(n + 1))    
     {lpm_nrow [i] -= 0x4000;/* ����� ���� � ���.����� */
  continue;
     }
    if (ir < 0) ir = -ir;
    l0 = lpm_icol [ir - 1];	/* ��砫� �⮫�� */
    l1 = lpm_icol [ir] - 2;	/* ����� �⮫�� */
    lpm_iacol [il] = l0; /* ����樨 ��砫 �⮫�殢 ����� */
/* ������ �᫠ ������⮢ ����᭮� ������ */
    for (ls = l0; ls <= l1; ls++)
     {lpm_ncol [il]++;		/* � �⮫��� */
      itb++;			/* �ᥣ� */
      i21 = lpm_ibi [ls];
      k = abs (i21) - 1;
      lpm_nrow [k]++;		/* � ��ப�� */
     }
    if (i != il) lpm_ibase [i] = 0;
    lpm_ibase [il] = ir;	/* 㯫�⭥��� ibase */
    il++;
   }
  if ((unsigned int)(itb + l) > lpm_space)
   {
#ifdef WINDOWS
    GlobalUnlock (hLpm_iacol);
    GlobalUnlock (hLpm_nrow);
    GlobalUnlock (hLpm_ncol);
#endif
return (-5);
   }
/* ���� �࠭ᯮ��஢����� ������ */
  lpm_ips [0] = 0;	/* � ibj ���� ��� �� ��� */
#ifdef WINDOWS
  lpm_iarow = (lpm_num *) GlobalLock (hLpm_iarow);
#endif
  lpm_iarow [0] = 0;
/* ����樨 ��砫 ��ப �࠭ᯮ��஢����� ������ */
  for (i = 1; i <= m; i++)
   {j = lpm_nrow [i - 1];
    if (j < 0) j += 0x4000;
    lpm_ips [i] = lpm_ips [i - 1] + j;
    lpm_iarow [i] = lpm_ips [i];
   }
  for (j = 0; j < il; j++) /* 横� �� ������ �⮫�栬 */
   {ls = lpm_iacol [j];
    while (1)
     {ir = lpm_ibi [ls];	/* ����� ��ப� */
      if (ir == 0)
    break;     /* ���稫�� �⮫��� */
      if (ir < 0) ir = -ir;
      ir--;
      l0 = lpm_ips [ir];
      lpm_ibj [l0] = j;  /* ������ ����� �⮫�� */
      lpm_ips [ir]++;	/* ⥪��� ������ ��ப� � ibj */
      ls++;
   } }
  for (i = 0; i < lpm_nips; i++) lpm_ips [i] = 0;
  nk = 0;		/* ���稪 ᯠ���� */
  nr = 0;		/* ���稪 ��㣮���� */
  while (nr + nk < il) /* 横� ࠧ��� �� ���. � ᯠ��� */
   {while (1)	/* 横� ����ᥭ�� �⮫�殢 � ᯠ��� */
     {
#ifdef WINDOWS
      if (lpm_WND)
       {GlobalUnlock (hLpm_iarow);
	GlobalUnlock (hLpm_iacol);
	GlobalUnlock (hLpm_nrow);
	GlobalUnlock (hLpm_ncol);
ERR_RET (lpm_to_wnd ());
	lpm_ncol = (int *) GlobalLock (hLpm_ncol);
	lpm_nrow = (int *) GlobalLock (hLpm_nrow);
	lpm_iacol = (lpm_num *) GlobalLock (hLpm_iacol);
	lpm_iarow = (lpm_num *) GlobalLock (hLpm_iarow);
       }
#endif
/* ���� �������쭮�� �᫠ ������⮢ � ��ப� */
      ir = 0;
      is = 0x4000;
      for (i = 0; i < m; i++)
       {jis = lpm_nrow [i];
	if (jis > 0 && jis < is)
	 {ir = i + 1;	/* ��ப�, ��� �� ������� */
	  is = jis;	/* �᫮ ������⮢ */
	  if (is == 1)
      break; /* ���� ��ப� � ����� ������⮬ */
       } }
      if (is == 1 || ir == 0)
    break;
/* � ����� ����᭮� �⮫��, ���ᥪ��饬�� � ��ப�� */
/* ����� is, �᫮ ������⮢ ���ᨬ��쭮 */
      k1 = 0;
      k = -1;
      for (j = 0; j < il; j++)
       {i = lpm_ncol [j];
	if (i == 0 || i < k1)
      continue;
	ls = lpm_iacol [j];
	xm = 0.;	/* max �।� ��ப ����� is */
	j2 = 0;
	while (1)   /* ���ᬮ�� j-�� ����᭮�� �⮫�� */
	 {i1 = lpm_ibi [ls];
	  if (i1 == 0)
	break;
	  if (lpm_nrow [i1 - 1] == is)
	   {j2 = 1;   /* ��� �⮫��� - �������� � ᯠ��� */
	    zm = fabs (lpm_b [ls]);
	    if (rough(zm) > rough(xm)) xm = zm;
	    if (i != k1)
	     {k1 = i;	/* �᫮ ������⮢ */
	      k = j;/* ����� �����.�⮫��, ��� �� ��� */
	   } }
	  ls++;
	 }
	if (k == j || j2 && rough(xm) < rough(z))
	 {z = xm;
	  k = j;
       } }
/* �⮫��� k �������� � ᯠ�� */
      lpm_ncol [k] = 0;
      nk++;
/* ����ᨬ ����� �⮫�殢-ᯠ���� � ips � (m-1)-�� ����� */
      lpm_ips [m - nk] = k;	/* ��� �⮫�殢 �� ��� */
/* �������� ����祭���� �⮫�� ᭨���� � ��� � nrow */
      ir = 0;
      ls = lpm_iacol [k];
      while (1)
       {i = lpm_ibi [ls];
	if (i == 0)
      break;
	pnum = lpm_nrow + i - 1;
	if (*pnum > 0) (*pnum)--;
	if (*pnum == 1) ir = i;  /* ������ ��ப� ir */
	ls++;	  /* � ����� ������⮬, ��� �� ������� */
       }
      if (ir != 0)
    break;
     }  	/* ����� 横�� ᯠ���� */
    if (ir == 0)
  break;
/* 横� ����ᥭ�� �⮫�殢 � ��㣮��� */
    while (1)	/* ir - ����� ��ப�, ����� �� ������� */
     {
#ifdef WINDOWS
      if (lpm_WND)
       {GlobalUnlock (hLpm_iarow);
	GlobalUnlock (hLpm_iacol);
	GlobalUnlock (hLpm_nrow);
	GlobalUnlock (hLpm_ncol);
ERR_RET (lpm_to_wnd ());
	lpm_ncol = (int *) GlobalLock (hLpm_ncol);
	lpm_nrow = (int *) GlobalLock (hLpm_nrow);
	lpm_iacol = (lpm_num *) GlobalLock (hLpm_iacol);
	lpm_iarow = (lpm_num *) GlobalLock (hLpm_iarow);
       }
#endif
      rs = lpm_iarow [ir - 1]; /* ��砫� ��ப�  � ibj */
      r1 = lpm_iarow [ir];    /* ��砫� ᫥���饩 ��ப� */
/* ���� � ir-� ��ப� �⮫�� ���㫥��� ����� */
      while (1)
       {i = lpm_ibj [rs];    /* ����� ����᭮�� �⮫�� */
	k1 = lpm_ncol [i]; /* �᫮ ������⮢ � �⮫�� */
	if (k1 > 0)
	 {k = i; /* �������� ������ �⮫���, */
      break;			/* ��� �� ��� */
	 }
	rs++;
	if (rs >= r1)	/* �� ��諨 �� ������ �⮫�� */
	 {
#ifdef WINDOWS
	  GlobalUnlock (hLpm_iarow);
	  GlobalUnlock (hLpm_iacol);
	  GlobalUnlock (hLpm_nrow);
	  GlobalUnlock (hLpm_ncol);
#endif
return (-8);  /* � ir-� ��ப� */
       } }
      lpm_ncol [k] = 0;
      l0 = ls = lpm_iacol [k];/* ��砫� �⮫�� � ����� */
      xm = 0.;		/* max �� �⮫��� */
      z = lpm_EPSpiv; /* max �� �������⠬ � ��.�������� */
      is = 0;		/* ��.��ப� ��� ᫥���饣� 蠣� */
      ir = 0;	   /* �饬 ��.��ப� �।� ��� nrow = 1 */
      while (1)     /* ��ᬮ�� ������ ����᭮�� �⮫�� */
       {i = lpm_ibi [ls];
	if (i == 0)
      break;
	zm = fabs (lpm_b [ls]);
	if (rough(zm) > rough(xm)) xm = zm;
	pnum = lpm_nrow + i - 1;
	if (*pnum > 0)
	 {if (*pnum == 1 && rough (zm) > rough (z))
	   {z = zm;
	    ir = i;  /* �������� � ��.�������� */
	    l1 = ls;  /* ��� ���� � ����� */
	   }
	  (*pnum)--;  /* ᭨���� � ��� � nrow */
	  if (*pnum == 1) is = i; /* ������ ��ப�  */
	 }			  /* � ����� ������⮬ */
	ls++;
       }	/* ����� 横�� ������ ����᭮�� �⮫�� */
      if (ir == 0)
       {
#ifdef WINDOWS
	GlobalUnlock (hLpm_iarow);
	GlobalUnlock (hLpm_iacol);
	GlobalUnlock (hLpm_nrow);
	GlobalUnlock (hLpm_ncol);
#endif
return (-7);
       }
      if (rough(xm) != 0)
	rough(xm) = rough(lpm_ETMLt) rough_mult rough(xm);
      if (rough(z) <= rough(xm)) /* ��� ��.������� */
       {nk++;	   /* ������� �⮫��� � ᯠ��� */
	lpm_ips [m - nk] = k;
    break;
       }
/* ⥯��� ������ �⮫��� ��訩 */
      it += k1;
      u = lpm_b [l1];	/* ������ ������� */
      lpm_nrow [ir - 1] = -lpm_ibase [k];  /* �����騩 */
			/* ����� k-�� ����᭮�� �⮫�� */
      if (k1 == 1)	/* � �⮫�� �ᥣ� ���� ������� */
       {b3 = fabs (u - 1.0);	  /* � �� ࠢ�� ������ */
	if (rough(b3) <= rough(lpm_EPSrel))
	 {if (lpm_PRNT > 2) fprintf(prn_file, "        *1");
	  nr++;
    break;
       } }
      else  /* ��७�� �������� ������� � ��砫� �⮫�� */
       {if (l0 != l1)
	 {lpm_b [l1] = lpm_b[l0];
	  lpm_ibi [l1] = lpm_ibi[l0];
	  lpm_b [l0] = u;
	  lpm_ibi [l0] = ir;
       } }
      lpm_ips [nr++] = l0;	 /* ����砥� �⮫��� */
				/* � ���⨯������� */
/* �����-����⪠ � ���� ���⨯������ */
      pibi = lpm_ibi + ls - 1;
      *pibi = - *pibi;
      if (lpm_PRNT > 2) fprintf (prn_file, " %9g", u);
      if (is == 0)
    break;
      ir = is;
     }			/* ����� 横�� ��㣮���� */
   }	/* ����� 横�� ࠧ��� �� ��㣮��� � ᯠ��� */
#ifdef WINDOWS
  GlobalUnlock (hLpm_iarow);
  GlobalUnlock (hLpm_iacol);
#endif
  lpm_ipovt++;
  if (lpm_PRNT > 1)
   {if (lpm_PRNT > 2) fprintf (prn_file, "\n");
    fprintf (prn_file, "%s\n  %6d %6d %6d %6d %6d\n",
	lpm_inform (-20),lpm_ipovt,il, nk,itb, it);
   }
  nuel = l;	/* ��᫥���� ����⮥ ���� � ����� */
  nml = m + nk; /* ᢮����� ips ��᫥ ����砭�� �ᥣ� */
  iun = nml;	/* ips ��� U-���⨯�����஢ */
  while (nk) /* 横� ࠧ�襭�� ᯠ���� */
   {
#ifdef WINDOWS
    if (lpm_WND)
     {GlobalUnlock (hLpm_nrow);
      GlobalUnlock (hLpm_ncol);
ERR_RET (lpm_to_wnd ());
      lpm_ncol = (int *) GlobalLock (hLpm_ncol);
      lpm_nrow = (int *) GlobalLock (hLpm_nrow);
     }
#endif
    i21 = m - nk;	/* ����ࠥ� ᯠ�� �� �⥪� */
    k = lpm_ips [i21];	  /* ����� ᯠ��� � ����� */
    lpm_ips [i21] = 0;
    nk--;
    jj = lpm_ibase [k] - 1;
    ls = lpm_icol [jj];    /* ��砫� ᯠ��� � ����� */
/* ������ ᯠ��� � xk */
    for (i = 0; i < m; i++) lpm_xk [i] = 0.;
    while (1)
     {i1 = lpm_ibi [ls];
      if (i1 == 0)
    break;
      lpm_xk [i1 - 1] = lpm_b [ls];
      ls++;
     }
/* ࠧ������� ᯠ��� �� ������ */
    lpm_nml = nr;
    lpm_d = 1;
    lpm_solve ();
    nuel++;
    i1 = 0;
    ir = 0;	/* ����� ��.��ப� */
    xm = 0.;	/* max abs (xk [i]) */
    z = 0.;	/* abs (��.�������) */
    l0 = nuel; /* ���� ��� ������� � ��砫� U-����-� */
    for (i = 0; i < m; i++)
     {b2 = fabs (lpm_xk [i]);
      if (rough(b2) <= rough(lpm_EPS))
    continue;
      if (rough(b2) > rough(xm)) xm = b2;
      if (lpm_nrow [i] >= 0)
/* �����⭮� ���� � �����: */
/* ����������� L-���⨯������ � xk � ncol */
       {lpm_xk [i1] = lpm_xk [i];  /* b - � ��砫� xk */
	lpm_ncol [i1] = i + 1;   /* ibi - � ��砫� ncol */
	if (rough(b2) > rough(z))
	 {i2 = i1;	/* ���� ��.������� � xk, ncol */
	  z = b2;	/* abs (��.�������) */
	  ir = i + 1;	/* ��.��ப�, ��� �� ������� */
	  u = lpm_xk [i];  /* ��.������� */
	 }
	i1++;
       }
      else
/* �� �����⭮� ���� � �����: */
/* ���������� U-���⨯������ */
       {nuel++;
	if (nuel > lpm_space)
	 {
#ifdef WINDOWS
	  GlobalUnlock (hLpm_nrow);
	  GlobalUnlock (hLpm_ncol);
#endif
return (-5);
	 }
	lpm_b [nuel] = lpm_xk [i];
	lpm_ibi [nuel] = i + 1;
     } }
    if (rough(xm) != 0)
      rough(xm) = rough(lpm_ETMLs) rough_mult rough(xm);
    if (rough (z) <= rough(xm))
      ir = 0;		/* ��.������� ��� */
    if (ir == 0)	/* L-���⨯������ ���� */
/* �� L- � U-���⨯������� 㭨�⮦��� */
     {nuel = l0 - 1;
      if (lpm_PRNT > 2) fprintf (prn_file, lpm_inform(-16));
  continue;
     }
    if (lpm_PRNT > 2) fprintf (prn_file, " %9g", u);
    lpm_b [l0] = 1.;	/* ��.������� U-���⨯������ */
    lpm_ibi [l0] = ir;
    lpm_ips [--iun] = l0;	/* U-���⨯������ */
    pibi = lpm_ibi + nuel; /* �����-����⪠ � ���� */
    *pibi = - *pibi;	   /*    ���⨯������    */
/* ���������� L-���⨯������ */
    lpm_ips [nr++] = nuel + 1;	/* L-���⨯������ */
    if (i2 != 0)
/* ��७�� ��.������� � ��砫� xk, ncol */
     {lpm_xk [i2]   = lpm_xk [0];
      lpm_ncol [i2] = lpm_ncol [0];
      lpm_xk [0]   = u;
      lpm_ncol [0] = ir;
     }
    pnum = lpm_ncol + i1 - 1; /* �����-����⪠ � ���� */
    *pnum = - *pnum;	      /*    ���⨯������    */
    for (i = 0; i < i1; i++)
     {nuel++;
      if (nuel > lpm_space)
       {
#ifdef WINDOWS
	GlobalUnlock (hLpm_nrow);
	GlobalUnlock (hLpm_ncol);
#endif
return (-5);
       }
      lpm_b [nuel] = lpm_xk [i];
      lpm_ibi [nuel] = lpm_ncol [i];
     }
    lpm_nrow [ir - 1] = -lpm_ibase [k];/* �����騩 ����� */
				/* k-�� ����᭮�� �⮫�� */
   }			/* ����� 横�� ࠧ�襭�� ᯠ���� */
#ifdef WINDOWS
  GlobalUnlock (hLpm_ncol);
#endif
  lpm_nml = nml;
  lpm_ibase [m - 1] = 0; /* �ਧ��� ��।��뢠��� ����� */
  for (i = 0; i < m; i++)
   {ir = -lpm_nrow [i];
    lpm_ibase [i] = (ir <= 0 || ir > n) ? 0 : ir;
   }
#ifdef WINDOWS
  GlobalUnlock (hLpm_nrow);
#endif
  lpm_ips [lpm_nml] = nuel + 1;
  if (lpm_PRNT > 2) fprintf (prn_file, "\n");
return (0);
 }    /* lpm_lumult */

void lpm_solve (void)
/* �襭�� ��⥬� �������� �ࠢ����� �� �᭮�� */
/* ���⨯����⨢���� �।�⠢����� ������ */
 {double u, u1;
  int l, i, ir, ir1;
  lpm_num ls;
  lpm_num  *pips;

  if (lpm_d) pips = lpm_ips;
  else pips = lpm_ips + lpm_nml - 1;

  for (l = 0; l < lpm_nml; l++)
   {ls = *pips;   /* ��砫� ���⨯������ � ����� */
    if (lpm_d) pips++;
    else pips--;
    if (ls == 0)
  continue;
    ir1 = lpm_ibi [ls];
    ir = abs (ir1) - 1;/* ����� ��.��ப�, ��� �� ��� */
    u = lpm_b [ls];
    u1 = lpm_xk [ir];
    if (lpm_d)
/* �襭�� ��אַ� ��⥬� */
     {u1 /= u;
      lpm_xk [ir] = u1;
      while (ir1 > 0)
       {ir1 = lpm_ibi [++ls];
	i = abs (ir1) - 1;
	lpm_subtr (lpm_xk + i, u1 * lpm_b [ls]);
     } }
    else
/* �襭�� �����⢥���� ��⥬� */
     {while (ir1 > 0)
       {ir1 = lpm_ibi [++ls];
	i = abs (ir1) - 1;
	lpm_subtr (&u1, lpm_xk [i] * lpm_b [ls]);
       }
      lpm_xk [ir] = u1 / u;
   } }
 }    /* lpm_solve */

void lpm_subtr (lpm_pdouble s, double x)
/* ���������� 童��  x  � �㬬�  *s */
 {float z, z1;
  z  = fabs (*s);
  z1 = fabs (*s -= x);
  if (rough (z) != 0)
    rough (z) = rough(z) rough_mult rough(lpm_EPSrel);
  if (rough(z1) <= rough(z)) *s = 0.;
 }    /* lpm_subtr */
