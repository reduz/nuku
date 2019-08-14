


#define RED(p_v) ((p_v >> 10) & 0x1F)
#define GREEN(p_v) ((p_v >> 5) & 0x1F)
#define BLUE(p_v) (p_v & 0x1F)


//0x739C
#define FIX_CRANGE(p_v) (p_pal[p_v]&0x739C)
//#define FIX_CRANGE(p_v) (p_pal[p_v]&0x7BDE)

/*
void copy_to_screen_and_blur(unsigned short*p_dst,unsigned char*p_src,unsigned short*p_pal,int p_w,int p_h) {
    int i,j;
    unsigned short val;

    unsigned char  n[9][9];

    for(i=1;i<p_h;i++) {
	for(j=1;j<p_w;j++) {

            n[0][0]=p_src[320*(i-1)+j-1];
            n[0][1]=p_src[320*(i)+j-1];
            n[0][2]=p_src[320*(i+1)+j-1];
            n[1][0]=p_src[320*(i-1)+j];
            n[1][1]=p_src[320*(i)+j];
            n[1][2]=p_src[320*(i+1)+j];
            n[2][0]=p_src[320*(i-1)+j+1];
            n[2][1]=p_src[320*(i)+j+1];
            n[2][2]=p_src[320*(i+1)+j+1];


	    p_dst[640*i*2+j*2]=p_pal[ (n[0][0]==n[0][1] && n[0][0]==n[1][0]) ? n[0][0] : n[1][1] ];
            p_dst[640*i*2+j*2+1]= p_pal[ (n[2][0]==n[2][1] && n[2][0]==n[1][0]) ? n[2][0] : n[1][1] ];
            p_dst[640*(i*2+1)+j*2]= p_pal[ (n[0][2]==n[0][1] && n[0][2]==n[1][0]) ? n[0][2] : n[1][1] ];
            p_dst[640*(i*2+1)+j*2+1]= p_pal[ (n[2][2]==n[2][1] && n[2][2]==n[1][2]) ? n[2][2] : n[1][1] ];
	}
    }
}
*/

void copy_to_screen(unsigned char*p_dst,unsigned char*p_src,unsigned short*p_pal,int p_w,int p_h) {

    int i;
    for(i=0;i<p_h;i++) {

        unsigned char res;
	int count=p_w-1;
	while(count--) {


            res=p_src[320*i+count];
	    p_dst[640*(i*2)+count*2]=res;
	    p_dst[640*(i*2)+count*2+1]=res;
	    p_dst[640*(i*2+1)+count*2]=res;
	    p_dst[640*(i*2+1)+count*2+1]=res;
	}
    }
}

void copy_to_screen_and_blur(unsigned char*p_dst,unsigned char*p_src,unsigned short*p_pal,int p_w,int p_h) {
    int i,j;
    unsigned short val;

    unsigned short  n[9][9];
    unsigned char  f[9][9];

    for(i=1;i<(p_h-1);i++) {
	for(j=1;j<(p_w-1);j++) {

            f[0][0]=p_src[320*(i-1)+j-1];
            f[0][1]=p_src[320*(i)+j-1];
            f[0][2]=p_src[320*(i+1)+j-1];
            f[1][0]=p_src[320*(i-1)+j];
            f[1][1]=p_src[320*(i)+j];
            f[1][2]=p_src[320*(i+1)+j];
            f[2][0]=p_src[320*(i-1)+j+1];
            f[2][1]=p_src[320*(i)+j+1];
	    f[2][2]=p_src[320*(i+1)+j+1];

            n[0][0]=FIX_CRANGE(f[0][0]);
            n[0][1]=FIX_CRANGE(f[0][1]);
            n[0][2]=FIX_CRANGE(f[0][2]);
            n[1][0]=FIX_CRANGE(f[1][0]);
            n[1][1]=FIX_CRANGE(f[1][1]);
            n[1][2]=FIX_CRANGE(f[1][2]);
            n[2][0]=FIX_CRANGE(f[2][0]);
            n[2][1]=FIX_CRANGE(f[2][1]);
	    n[2][2]=FIX_CRANGE(f[2][2]);

	    if ( n[1][0]==n[1][2] && n[1][0]==n[0][1] && n[1][0]==n[2][1] ) {


		p_dst[640*i*2+j*2]= f[1][1];
		p_dst[640*i*2+j*2+1]=  f[1][1];
		p_dst[640*(i*2+1)+j*2]=  f[1][1];
		p_dst[640*(i*2+1)+j*2+1]=  f[1][1];

	    } else {


		p_dst[640*i*2+j*2]= (n[0][0]==n[0][1] && n[0][0]==n[1][0]) ? f[1][0] : f[1][1];
		p_dst[640*i*2+j*2+1]=  (n[2][0]==n[2][1] && n[2][0]==n[1][0]) ? f[2][0] : f[1][1];
		p_dst[640*(i*2+1)+j*2]=  (n[0][2]==n[0][1] && n[0][2]==n[1][2]) ? f[0][2] : f[1][1];
		p_dst[640*(i*2+1)+j*2+1]=  (n[2][2]==n[2][1] && n[2][2]==n[1][2]) ? f[1][2] : f[1][1];
	    }

	}
    }
}


void copy_to_screen_and_blur_a(unsigned short*p_dst,unsigned char*p_src,unsigned short*p_pal,int p_w,int p_h) {
    int i,j;
    unsigned short val;
    unsigned short val_d;
    unsigned short val_u;
    unsigned short val_ld;
    unsigned short val_rd;
    unsigned short val_lu;
    unsigned short val_ru;
    unsigned short aux;
    unsigned short final_dl;
    unsigned short final_dr;
    unsigned short final_ul;
    unsigned short final_ur;

    for(i=1;i<p_h;i++) {
	for(j=1;j<p_w;j++) {

	    val=p_pal[p_src[320*i+j]];
            val_d=p_pal[p_src[320*(i+1)+j]];
            val_u=p_pal[p_src[320*(i-1)+j]];
            val_ld=p_pal[p_src[320*(i+1)+(j-1)]];
	    val_rd=p_pal[p_src[320*(i+1)+(j+1)]];
            val_lu=p_pal[p_src[320*(i-1)+(j-1)]];
	    val_ru=p_pal[p_src[320*(i-1)+(j+1)]];

	    final_dl=((RED(val)*2+RED(val_ld)+RED(val_d)) >> 2) << 10;
	    final_dl|=((GREEN(val)*2+GREEN(val_ld)+GREEN(val_d)) >> 2) << 5;
	    final_dl|=((BLUE(val)*2+BLUE(val_ld)+BLUE(val_d)) >> 2);

	    final_dr=((RED(val)*2+RED(val_rd)+RED(val_d)) >> 2) << 10;
	    final_dr|=((GREEN(val)*2+GREEN(val_rd)+GREEN(val_d)) >> 2) << 5;
	    final_dr|=((BLUE(val)*2+BLUE(val_rd)+BLUE(val_d)) >> 2);

	    final_ul=((RED(val)*2+RED(val_lu)+RED(val_u)) >> 2) << 10;
	    final_ul|=((GREEN(val)*2+GREEN(val_lu)+GREEN(val_u)) >> 2) << 5;
	    final_ul|=((BLUE(val)*2+BLUE(val_lu)+BLUE(val_u)) >> 2);

	    final_ur=((RED(val)*2+RED(val_ru)+RED(val_u)) >> 2) << 10;
	    final_ur|=((GREEN(val)*2+GREEN(val_ru)+GREEN(val_u)) >> 2) << 5;
	    final_ur|=((BLUE(val)*2+BLUE(val_ru)+BLUE(val_u)) >> 2);


            p_dst[640*i*2+j*2]=final_ul;
            p_dst[640*i*2+j*2+1]=final_ur;
            p_dst[640*(i*2+1)+j*2]=final_dl;
            p_dst[640*(i*2+1)+j*2+1]=final_dr;
	}
    }
}


