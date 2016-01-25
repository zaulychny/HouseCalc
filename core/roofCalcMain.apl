roofCalcMain;Q;Qw;Qs;Q_rep_units;pa2kgm;Q_rep_si_fact;Q_rep_units_2_si;Q_rep_units_txt;Q_rep_units_si;Q_to_si;Q_si_to_rep;line_txt;slope_angle;slope_length;slope_wall_cover_length;length_rep_unit_txt;length_si_2_rep_unit;roof_house_w_cover_length;plot_h;plot_w;wall_x;pixels_num;pixel_w;pixel_h;wall_y;wall_ln;slope_wall_cover_act_length;Qn;Qt;Fn;Ft;w;F_rep_units_txt;F_si_to_rep;Mmax;M_si_to_rep;M_rep_units_txt;bent_ratio;b;h;E;Mr;E_rep_si_fact;E_rep_units_txt;bent_rad;bent_ang;Angle_rep_units_txt;E_material_txt;Ge;Qr;Qi;K_rep_units_txt;K_si2ru_fact;Km_rel;Km_abs;Qri;Qrc;Qrr;roof_house_width;roof_house_length;roof_rafter_span;Qr_rep_units_txt
⍝ ... Find optimal sizes for roof construction elements (rafters, jacks etc)

⍝_________________________
⍝ ... Initialization
⍝¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
 1 0 strWrt'Calculate house roof'

⍝_________________________
⍝ ... Define basic geometry of the roof
⍝¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
 1 1 strWrt'Reading roof geometry...'

 roof_house_width←10        ⍝ ... Wall to wall length to be covered by roof
 roof_house_length←12.5     ⍝ ... Wall to wall width to be covered by roof
 roof_rafter_span←1         ⍝ ... Distance between rafters

 slope_angle←30 ⍝ ... Wall roof slope angle in degrees                 60  30
 slope_wall_cover_length←0.3 ⍝ ...  Slope horizontal wall cover, (m)
 roof_house_w_cover_length←12.5 ⍝ ...  Roof cover house by width,  (m) 5.5  12.5
 b←50÷1000         ⍝ ... Standard Rafter width, espressed in SI units, m
 h←150÷1000        ⍝ ... Standard Rafter height, m
 length_rep_unit_txt←'mm'
 length_si_2_rep_unit←1000

 0 0 strWrt'                 Slope angle: ',(fmtAmt slope_angle),' deegrees'
 0 0 strWrt'Wall cover by roof (outdoor): ',(fmtAmt slope_wall_cover_length×length_si_2_rep_unit),' ',length_rep_unit_txt
 0 0 strWrt'  Roof wall to wall distance: ',(fmtAmt roof_house_w_cover_length×length_si_2_rep_unit),' ',length_rep_unit_txt

⍝_________________________
⍝ ... Calculate geometry of roof elements
⍝¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
 1 1 strWrt'Calculating slope geometry...'
 slope_length←0 ⍝ ...  Total slope length (m)
 slope_wall_cover_act_length←0
 :If 0<cos(slope_angle)                                             ⍝ ...  Slope wall cover (actual), (m)
     slope_wall_cover_act_length←slope_wall_cover_length÷cos(slope_angle) ⍝ ...  Slope wall cover, (m)
 :EndIf
 :If 0<cos(slope_angle)                                             ⍝ ...  Slope length depends on roof wall cover, (m)
     slope_length←slope_wall_cover_act_length+((roof_house_w_cover_length÷2)÷cos(slope_angle)) ⍝ ...  Slope wall cover, (m)
 :EndIf

 0 0 strWrt'          Slope total length: ',(fmtAmt slope_length×length_si_2_rep_unit),' ',length_rep_unit_txt
 0 0 strWrt'     Slope wall cover length: ',(fmtAmt slope_wall_cover_act_length×length_si_2_rep_unit),' ',length_rep_unit_txt

⍝_________________________
⍝ ... Plot the roof
⍝¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
 plot_w←1+⌈(2×slope_wall_cover_length)+roof_house_w_cover_length
 plot_h←1+⌈slope_length
 pixels_num←50
 pixel_w←(⌊/plot_h plot_w)÷pixels_num
 plot_h plot_w←⌈(plot_h plot_w)÷pixel_w
 drawing←(plot_h plot_w)⍴''

 wall_x←1+⌈(slope_wall_cover_length÷pixel_w)
 wall_y←1+⌈(slope_wall_cover_length÷pixel_w)
 drawing←drawing plotCanvas(⊂wall_x,wall_y)  ⍝ ... Start plot here

 wall_ln←getLineXYAL(wall_x,wall_y)(slope_angle,((slope_length-slope_wall_cover_act_length)÷pixel_w))
 drawing←drawing plotCanvas(wall_ln)
 wall_ln←getLineXYAL(wall_x,wall_y)((180+slope_angle),(slope_wall_cover_act_length÷pixel_w))
 drawing←drawing plotCanvas(wall_ln)
 wall_ln←getLine(wall_x,wall_y)(wall_x,0)
 drawing←drawing plotCanvas(wall_ln)

 wall_ln←getLineXYAL(wall_x,wall_y)(0,(roof_house_w_cover_length÷pixel_w))
 drawing←drawing plotCanvas(wall_ln)

 (wall_x wall_y)←⊃¯1↑wall_ln
 wall_ln←getLineXYAL(wall_x,wall_y)((180-slope_angle),((slope_length-slope_wall_cover_act_length)÷pixel_w))
 drawing←drawing plotCanvas(wall_ln)
 wall_ln←getLineXYAL(wall_x,wall_y)((-slope_angle),(slope_wall_cover_act_length÷pixel_w))
 drawing←drawing plotCanvas(wall_ln)
 wall_ln←getLine(wall_x,wall_y)(wall_x,0)
 drawing←drawing plotCanvas(wall_ln)

 1 1 strWrt'Check roof drawing: ⍝ drawing'

⍝_________________________
⍝ ... Define basic load on the roof
⍝¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
 Ge←9.80665        ⍝ Earth acceleration g = 9.80665 m/s2
 pa2kgm←1÷9.80665
 Qs←1600 ⍝ Pressure on the roof from snow (Pa)
 Qw←400  ⍝ Pressure on the roof from wind (Pa)
 Qrc←5×Ge    ⍝ Pressure on the roof from cover (Pa), metal tiles , 5 kg/m2
 Qri←10×Ge    ⍝ Pressure on the roof from insulation (Pa), rockwool , 10 kg/m2
 Qrr←800×Ge×h×b    ⍝ Own mass Pressure on the roof rafter (Pa), wood , (1 m rafter mass) density=800 kg/m3
 Q←Qw+Qs+Qrc+Qri
 Q←Qrr+(Q×roof_rafter_span)     ⍝ ... Recalculate into Force per length of the rafter

 Q_rep_units_txt←'kg÷m2'   ⍝ ... 1 kg-fource per square meter i.e. load from 1 kg on 1 sq. meter
 Qr_rep_units_txt←'kg÷m'   ⍝ ... 1 kg-fource per rafter meter i.e. load from 1 kg on 1 m of rafter
 Q_si_to_rep←1÷Ge        ⍝ 1 Pa = 1 N/m2 = (1÷9.80665) kgf/m2, Earth acceleration g = 9.80665 m/s2
 1 strWrt'Collecting load (Q) on the roof generated by different sources...'
 strWrt'             Snow: ',(fmtAmt 3 rnd Qs×Q_si_to_rep),' ',Q_rep_units_txt
 strWrt'             Wind: ',(fmtAmt 3 rnd Qw×Q_si_to_rep),' ',Q_rep_units_txt
 strWrt'       Roof cover: ',(fmtAmt 3 rnd Qrc×Q_si_to_rep),' ',Q_rep_units_txt
 strWrt'  Roof insulation: ',(fmtAmt 3 rnd Qri×Q_si_to_rep),' ',Q_rep_units_txt
 strWrt' Roof rafter mass: ',(fmtAmt 3 rnd Qrr×Q_si_to_rep),' ',Qr_rep_units_txt
 1 1 strWrt'   Total load: ',(fmtAmt 3 rnd Q×Q_si_to_rep),' ',Qr_rep_units_txt

⍝_________________________
⍝ ... Calculate forces applied on roof slope
⍝¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
 0 1 strWrt'Calculate forces applied on roof slope...'
 F_rep_units_txt←'kg'
 F_si_to_rep←Q_si_to_rep
 Qn←Q×cos(slope_angle)
 Qt←Q×sin(slope_angle)

 strWrt'           Slope normal load (Qn): ',(fmtAmt 3 rnd Qn×Q_si_to_rep),' ',Q_rep_units_txt
 strWrt'          Slope tensile load (Qt): ',(fmtAmt 3 rnd Qt×Q_si_to_rep),' ',Q_rep_units_txt

 w←(1+0.5×((cos(slope_angle))power 2))
 Fn←Q×slope_length×cos(slope_angle)
 Ft←Q×slope_length×sin(slope_angle)

 strWrt'    Slope normal total force (Fn): ',(fmtAmt 3 rnd Fn×F_si_to_rep),' ',F_rep_units_txt
 strWrt'   Slope tensile total force (Ft): ',(fmtAmt 3 rnd Ft×F_si_to_rep),' ',F_rep_units_txt

 Mmax←(Qn×(slope_length power 2))÷8             ⍝ ... Maximum benting momentum in the center of the rafter due to external load
 M_si_to_rep←F_si_to_rep
 M_rep_units_txt←'kg×m'
 0 1 strWrt'Slope max benting momentum (Mmax): ',(fmtAmt 3 rnd Mmax×M_si_to_rep),' ',M_rep_units_txt

⍝_________________________
⍝ ... Define criteria of roof mechanical stability
⍝¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
 bent_ratio←1÷200
 0 1 strWrt'    Roof rafter benting limit is: L÷',fmtAmt 3 rnd(bent_ratio power ¯1)

⍝_________________________
⍝ ... Calculate optimal rafter geometry
⍝¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
 0 1 strWrt'Calculate optimal geometry of the roof rafter...'
 b←50÷1000         ⍝ ... Standard Rafter width, espressed in SI units, m
 h←150÷1000        ⍝ ... Standard Rafter height, m
 E←10×10 power 9  ⍝ ... Modulus of Jung E=sigma÷de=F÷(S×de), Pa, Wood E = 10 GPa, Timber E = 12 GPa
 E_rep_units_txt←'kg÷mm2'
 E_material_txt←'Wood, (timber)'
 E_rep_si_fact←F_si_to_rep÷(1000 power 2)
 bent_ang←0.1 ⍝ ... bent angle (degrees) at the maximum, it is equivivalent to bent ratio e.g. L÷200
 bent_rad←bent_ratio
 bent_ang←rad2deg bent_rad  ⍝ ... redefine from maximum benting ratio
 Angle_rep_units_txt←'deg'
 0 0 strWrt'       Roof rafter standard  width: ',(fmtAmt 3 rnd(b×length_si_2_rep_unit)),' ',length_rep_unit_txt
 0 0 strWrt'       Roof rafter standard height: ',(fmtAmt 3 rnd(h×length_si_2_rep_unit)),' ',length_rep_unit_txt
 0 0 strWrt'              Roof rafter material: ',E_material_txt
 0 0 strWrt'   Roof rafter elastic modulus (E): ',(fmtAmt 3 rnd(E×E_rep_si_fact)),' ',E_rep_units_txt
 0 0 strWrt'     Roof rafter max benting angle: ',(fmtAmt 3 rnd(bent_ang)),' ',Angle_rep_units_txt

 Mr←2×b×E×tan(bent_ang)×((h÷2)power 2)÷2   ⍝ ... Get resistence momentum: df=E×de×dy×dz=[de=dx_comp÷dx=z×tan(a)]=(E×sin(a)×z)×dy×dz=>Mr=INTEGRAL(z×df)=INTEGRAL(E×sin(a)×(z^2)×dy×dz)
 0 0 strWrt'Rafters maximal momentum of resistance to the maximum benting (Mr): ',(fmtAmt 3 rnd Mr×M_si_to_rep),' ',M_rep_units_txt
 Km_rel←Mr÷Mmax
 Km_abs←Km_rel-1
 K_rep_units_txt←'%'
 K_si2ru_fact←100
 :If Mr<Mmax
     1 1 strWrt'[ROOF can CRASH]: Standard rafter can crash as resistance momentum is less than benting maximum momentum induced by total roof load!'
 :Else
     1 1 strWrt'    [ROOF is OK]: Standard rafter can handle total roof load as resistance momentum is more than benting maximum momentum induced by the load...'
 :EndIf
 0 0 strWrt'                  Rafters resistance momentum margin (Kr): abs=',(fmtAmt 3 rnd Km_abs×K_si2ru_fact),' ',K_rep_units_txt,', rel=',(fmtAmt 3 rnd Km_rel×K_si2ru_fact),' ',K_rep_units_txt

 1 1 strWrt'Calculate optimal height of the roof rafter...'
 h←2×(Mmax÷(b×E×tan(bent_ang)))power 0.5
 0 0 strWrt'       Roof rafter optimal height (it will resist to the load, benting to the allowed maximum): ',(fmtAmt 1 rnd(h×length_si_2_rep_unit)),' ',length_rep_unit_txt
