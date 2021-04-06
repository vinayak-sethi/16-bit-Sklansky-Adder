module SixteenbitSklanskyAdder(A, B, cin, sum, cout);

    input [15:0] A, B;
    input cin;
    output [15:0] sum;
    output cout;

    wire [15:0] initializeG;
    wire [15:0] initializeP;

    wire [15:0] level11;
    wire [15:0] level12;

    wire [15:0] level21;
    wire [15:0] level22;

    wire [15:0] level31;
    wire [15:0] level32;

    wire [15:0] level41;
    wire [15:0] level42;

    genvar i, j;
   
    for(i=0; i<16; i=i+1)
    begin
        assign initializeG[i] = A[i] & B[i];
        assign initializeP[i] = A[i] ^ B[i];
    end

// Black Cell G(i,j) = G(i,k) | (P(i,k) & G(k-1,j))
// Black Cell P(i,j) = P(i,k) & P(k-1,j)

// Gray Cell G(i,j) = G(i,k) | (P(i,k) & G(k-1,j))

//Multiple Valency Operation G(i,j) = G(i,k) | (P(i,k) & (G(k-1,l) | (P(k-1,l) & (G(l-1,m) | (P(l-1,m) & G(m-1,j))))))
//Multiple Valency Operation P(i,j) = P(i,k) & P(k-1,l) & P(l-1,m) & P(m-1,j)

//level 1

    for(j=0; j<8; j=j+1)
    begin
        assign level11[2*j] = initializeG[2*j];
        assign level12[2*j] = initializeP[2*j]; 
        assign level11[2*j+1] = initializeG[2*j+1] | (initializeG[2*j] & initializeP[2*j+1]);
        assign level12[2*j+1] = initializeP[2*j+1] & initializeP[2*j];
    end

//level 2

    for(j=0; j<4; j=j+1)
    begin
        assign level21[4*j] = level11[4*j];
        assign level22[4*j] = level12[4*j];
        assign level21[4*j+1] = level11[4*j+1];
        assign level22[4*j+1] = level12[4*j+1];
        assign level21[4*j+2] = level11[4*j+2] | (level11[4*j+1] & level12[4*j+2]);
        assign level22[4*j+2] = level12[4*j+2] & level12[4*j+1];
        assign level21[4*j+3] = level11[4*j+3] | (level11[4*j+1] & level12[4*j+3]);
        assign level22[4*j+3] = level12[4*j+3] & level12[4*j+1];
    end

//level3

    for(j=0; j<2; j=j+1)
    begin
        assign level31[8*j] = level21[8*j];
        assign level32[8*j] = level22[8*j];
        assign level31[8*j+1] = level21[8*j+1];
        assign level32[8*j+1] = level22[8*j+1];
        assign level31[8*j+2] = level21[8*j+2];
        assign level32[8*j+2] = level22[8*j+2];
        assign level31[8*j+3] = level21[8*j+3];
        assign level32[8*j+3] = level22[8*j+3];
        assign level31[8*j+4] = level21[8*j+4] | (level21[8*j+3] & level22[8*j+4]);
        assign level32[8*j+4] = level22[8*j+4] & level22[8*j+3];
        assign level31[8*j+5] = level21[8*j+5] | (level21[8*j+3] & level22[8*j+5]);
        assign level32[8*j+5] = level22[8*j+5] & level22[8*j+3];
        assign level31[8*j+6] = level21[8*j+6] | (level21[8*j+3] & level22[8*j+6]);
        assign level32[8*j+6] = level22[8*j+6] & level22[8*j+3];
        assign level31[8*j+7] = level21[8*j+7] | (level21[8*j+3] & level22[8*j+7]);
        assign level32[8*j+7] = level22[8*j+7] & level22[8*j+3];
    end
    
//level4
    for(j=0; j<1; j=j+1)
    begin
        assign level41[16*j] = level31[16*j];
        assign level42[16*j] = level32[16*j];
        assign level41[16*j+1] = level31[16*j+1];
        assign level42[16*j+1] = level32[16*j+1];
        assign level41[16*j+2] = level31[16*j+2];
        assign level42[16*j+2] = level32[16*j+2];
        assign level41[16*j+3] = level31[16*j+3];
        assign level42[16*j+3] = level32[16*j+3];
        assign level41[16*j+4] = level31[16*j+4];
        assign level42[16*j+4] = level32[16*j+4];
        assign level41[16*j+5] = level31[16*j+5];
        assign level42[16*j+5] = level32[16*j+5];
        assign level41[16*j+6] = level31[16*j+6];
        assign level42[16*j+6] = level32[16*j+6];
        assign level41[16*j+7] = level31[16*j+7];
        assign level42[16*j+7] = level32[16*j+7];
        assign level41[16*j+8] = level31[16*j+8] | (level31[16*j+7] & level32[16*j+8]);
        assign level42[16*j+8] = level32[16*j+8] & level32[16*j+7];
        assign level41[16*j+9] = level31[16*j+9] | (level31[16*j+7] & level32[16*j+9]);
        assign level42[16*j+9] = level32[16*j+9] & level32[16*j+7];
        assign level41[16*j+10] = level31[16*j+10] | (level31[16*j+7] & level32[16*j+10]);
        assign level42[16*j+10] = level32[16*j+10] & level32[16*j+7];
        assign level41[16*j+11] = level31[16*j+11] | (level31[16*j+7] & level32[16*j+11]);
        assign level42[16*j+11] = level32[16*j+11] & level32[16*j+7];
        assign level41[16*j+12] = level31[16*j+12] | (level31[16*j+7] & level32[16*j+12]);
        assign level42[16*j+12] = level32[16*j+12] & level32[16*j+7];
        assign level41[16*j+13] = level31[16*j+13] | (level31[16*j+7] & level32[16*j+13]);
        assign level42[16*j+13] = level32[16*j+13] & level32[16*j+7];
        assign level41[16*j+14] = level31[16*j+14] | (level31[16*j+7] & level32[16*j+14]);
        assign level42[16*j+14] = level32[16*j+14] & level32[16*j+7];
        assign level41[16*j+15] = level31[16*j+15] | (level31[16*j+7] & level32[16*j+15]);
        assign level42[16*j+15] = level32[16*j+15] & level32[16*j+7];
    end
    
    //sum
    assign sum[0] = cin ^ initializeP[0];

    for(i=0; i<15; i=i+1)
    begin
        assign sum[i+1] = level41[i] ^ initializeP[i+1];
    end
    
    //cout
    assign cout = level41[15];

endmodule

