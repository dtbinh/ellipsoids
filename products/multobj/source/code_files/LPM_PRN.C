extern int lpm_LNG;

char *lpm_inform (int no)
/* �뤠� ᮮ�饭�� �� ������ */
 {static char *inform [2][21] = {
   {"H�� �襭��",			 /* -1 */
    "��襭�� ����࠭�祭�",		 /* -2 */
    "�室 �� �筮��", 		 /* -3 */
    "�� �������� ������ ������� ����",/* -4 */
    "���� �����",			 /* -5 */
    "��� ������ �������",		 /* -6 */
    "�����, �� ��諨 �������� �������",/* -7 */
    "�����",				 /* -8 */
    "�������⨬� ⨯ ��ப�",  	 /* -9 */
    "��� ����",			 /*-10 */
    "-� �⮫��� ����ࠦ�������",	 /*-11 */
    "�⮫��� ࠧ��ࠦ�������",  	 /*-12 */
    "�������⨬����. ��� ���離�",	 /*-13 */
    "�㫥��� �������",  		 /*-14 */
    "- ��ப�", 			 /*-15 */
    "  ���襭",			 /*-16 */
    "��.����",  			 /*-17 */
    "max.����", 			 /*-18 */
    "� ��ப�", 			 /*-19 */
    "������ �⮫��� ᯠ���  ����  ���",
    "�筮���    �業��  ��.���  ���.����  楫.�㭪\
  �室 ��室 ��.��� ����  ���"
   },
   {"LP-problem is infeasible", 	/* -1 */
    "LP-problem is unbounded",  	/* -2 */
    "Insufficient precision",		/* -3 */
    "All possible pivots are too small",/* -4 */
    "Not enough memory",		/* -5 */
    "Too small pivot",  		/* -6 */
    "Damage, pivot not found",  	/* -7 */
    "Damage",				/* -8 */
    "Wrong type of row",		/* -9 */
    "No room",  			/*-10 */
    "-th column is frozen",		/*-11 */
    "Columns are unfrozen",		/*-12 */
    "Infeasibility. Max discrepancy",   /*-13 */
    "Zero element",			/*-14 */
    "- row",				/*-15 */
    "  rejected",			/*-16 */
    "pivot",				/*-17 */
    "max in column",			/*-18 */
    "in row",				/*-19 */
    "factorzn columns spikes  matr triang",
    "precision  maxrcst basrcst     pivot objective\
    in   out pivrow room  iter"
   }};
return (inform [lpm_LNG] [-(1 + no)]);
 }    /* ch_inform */
