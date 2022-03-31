module bk_adder_32(
    input	[31:0]	a,
    input   [31:0]  b,
    input 			cin,
    output 	[31:0]	sum,
    output		    cout
);
    //P,G
    wire [31:0] G, P, Carry, g, p;
    assign g = a & b;
    assign p = a ^ b;
    
    assign G = {g[31:1], (g[0]||(p[0]&&cin))};
    assign P = p;
    
    //level_1
    wire [15:0] level_1_G, level_1_P;
    genvar i;
    generate
        for(i=0; i<16; i=i+1)begin:level_1
            dot level_1_dot_u(G[i*2], P[i*2], G[i*2+1], P[i*2+1], level_1_G[i], level_1_P[i]);
        end
    endgenerate

    //level_2
    wire [7:0] level_2_G, level_2_P;
    generate
        for(i=0; i<8; i=i+1)begin:level_2
            dot level_2_dot_u(level_1_G[i*2], level_1_P[i*2], level_1_G[i*2+1], level_1_P[i*2+1], level_2_G[i], level_2_P[i]);
        end
    endgenerate

    //level_3
    wire [3:0] level_3_G, level_3_P;
    generate
        for(i=0; i<4; i=i+1)begin:level_3
            dot level_3_dot_u(level_2_G[i*2], level_2_P[i*2], level_2_G[i*2+1], level_2_P[i*2+1], level_3_G[i], level_3_P[i]);
        end
    endgenerate

    //level_4
    wire [1:0] level_4_G, level_4_P;
    dot level_4_dot_u1(level_3_G[0], level_3_P[0], level_3_G[1], level_3_P[1], level_4_G[0], level_4_P[0]);
    dot level_4_dot_u2(level_3_G[2], level_3_P[2], level_3_G[3], level_3_P[3], level_4_G[1], level_4_P[1]);

    //level_5
    wire level_5_G, level_5_P;
    dot level_5_dot_u(level_4_G[0], level_4_P[0], level_4_G[1], level_4_P[1], level_5_G, level_5_P);//Cout

    //level_6
    wire level_6_G, level_6_P;
    dot level_6_dot_u(level_4_G[0], level_4_P[0], level_3_G[2], level_3_P[2], level_6_G, level_6_P);//Carry[24]--(16+8)/2

    //level_7
    wire [2:0] level_7_G, level_7_P;
    dot level_7_dot_u1(level_3_G[0], level_3_P[0], level_2_G[2], level_2_P[2], level_7_G[0], level_7_P[0]);
    dot level_7_dot_u2(level_4_G[0], level_4_P[0], level_2_G[4], level_2_P[4], level_7_G[1], level_7_P[1]);
    dot level_7_dot_u3(level_6_G, level_6_P, level_2_G[6], level_2_P[6], level_7_G[2], level_7_P[2]);

    //level_8
    wire [6:0] level_8_G, level_8_P;
    dot level_8_dot_u1(level_2_G[0], level_2_P[0], level_1_G[2], level_1_P[2], level_8_G[0], level_8_P[0]);
    dot level_8_dot_u2(level_3_G[0], level_3_P[0], level_1_G[4], level_1_P[4], level_8_G[1], level_8_P[1]);
    dot level_8_dot_u3(level_7_G[0], level_7_P[0], level_1_G[6], level_1_P[6], level_8_G[2], level_8_P[2]);
    dot level_8_dot_u4(level_4_G[0], level_4_P[0], level_1_G[8], level_1_P[8], level_8_G[3], level_8_P[3]);
    dot level_8_dot_u5(level_7_G[1], level_7_P[1], level_1_G[10], level_1_P[10], level_8_G[4], level_8_P[4]);
    dot level_8_dot_u6(level_6_G, level_6_P, level_1_G[12], level_1_P[12], level_8_G[5], level_8_P[5]);
    dot level_8_dot_u7(level_7_G[2], level_7_P[2], level_1_G[14], level_1_P[14], level_8_G[6], level_8_P[6]);

    //level_9
    wire [14:0] level_9_G, level_9_P;
    dot level_9_dot_u1(level_1_G[0], level_1_P[0], G[2], P[2], level_9_G[0], level_9_P[0]);
    dot level_9_dot_u2(level_2_G[0], level_2_P[0], G[4], P[4], level_9_G[1], level_9_P[1]);
    dot level_9_dot_u3(level_8_G[0], level_8_P[0], G[6], P[6], level_9_G[2], level_9_P[2]);
    dot level_9_dot_u4(level_3_G[0], level_3_P[0], G[8], P[8], level_9_G[3], level_9_P[3]);
    dot level_9_dot_u5(level_8_G[1], level_8_P[1], G[10], P[10], level_9_G[4], level_9_P[4]);
    dot level_9_dot_u6(level_7_G[0], level_7_P[0], G[12], P[12], level_9_G[5], level_9_P[5]);
    dot level_9_dot_u7(level_8_G[2], level_8_P[2], G[14], P[14], level_9_G[6], level_9_P[6]);
    dot level_9_dot_u8(level_4_G[0], level_4_P[0], G[16], P[16], level_9_G[7], level_9_P[7]);
    dot level_9_dot_u9(level_8_G[3], level_8_P[3], G[18], P[18], level_9_G[8], level_9_P[8]);
    dot level_9_dot_u10(level_7_G[1], level_7_P[1], G[20], P[20], level_9_G[9], level_9_P[9]);
    dot level_9_dot_u11(level_8_G[4], level_8_P[4], G[22], P[22], level_9_G[10], level_9_P[10]);
    dot level_9_dot_u12(level_6_G, level_2_P, G[24], P[24], level_9_G[11], level_9_P[11]);
    dot level_9_dot_u13(level_8_G[5], level_8_P[5], G[26], P[26], level_9_G[12], level_9_P[12]);
    dot level_9_dot_u14(level_7_G[2], level_7_P[2], G[28], P[28], level_9_G[13], level_9_P[13]);
    dot level_9_dot_u15(level_8_G[6], level_8_P[6], G[30], P[30], level_9_G[14], level_9_P[14]);

    //Carry
    assign Carry[0] = cin;
    assign Carry[1] = G[0];
    assign Carry[2] = level_1_G[0];
    assign Carry[3] = level_9_G[0];
    assign Carry[4] = level_2_G[0];
    assign Carry[5] = level_9_G[1];
    assign Carry[6] = level_8_G[0];
    assign Carry[7] = level_9_G[2];
    assign Carry[8] = level_3_G[0];
    assign Carry[9] = level_9_G[3];
    assign Carry[10] = level_8_G[1];
    assign Carry[11] = level_9_G[4];
    assign Carry[12] = level_7_G[0];
    assign Carry[13] = level_9_G[5];
    assign Carry[14] = level_8_G[2];
    assign Carry[15] = level_9_G[6];
    assign Carry[16] = level_4_G[0];
    assign Carry[17] = level_9_G[7];
    assign Carry[18] = level_8_G[3];
    assign Carry[19] = level_9_G[8];
    assign Carry[20] = level_7_G[1];
    assign Carry[21] = level_9_G[9];
    assign Carry[22] = level_8_G[4];
    assign Carry[23] = level_9_G[10];
    assign Carry[24] = level_6_G;
    assign Carry[25] = level_9_G[11];
    assign Carry[26] = level_8_G[5];
    assign Carry[27] = level_9_G[12];
    assign Carry[28] = level_7_G[2];
    assign Carry[29] = level_9_G[13];
    assign Carry[30] = level_8_G[6];
    assign Carry[31] = level_9_G[14];

    //cout
    assign cout = level_5_G;
    assign sum = p ^ Carry;

endmodule

module dot(
    input g0,
    input p0,
    input g1,
    input p1,
    output g2,
    output p2
);

    assign g2 = g1 || (p1&&g0);
    assign p2 = p0 && p1;

endmodule
