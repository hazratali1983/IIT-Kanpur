#include<stdio.h>
#include<math.h>
#include<stdlib.h>
#include<complex.h>

struct comp{
	double re,im;
};
int opt;
double pi = 3.14159265358979323846;

struct comp* recursive_FFT(struct comp a[], int n){ /// 0 4 0 0 1.0 0 2.0 0 3.0 0
	if(n == 1){
		return a;
	}
	struct comp ae[n/2], ao[n/2],w,*ye,*yo;
	struct comp* y=(struct comp*)malloc(n*sizeof(struct comp));
	
	for(int i=0;i<n/2; i++){

		   ae[i].im = a[2*i].im;
		   ae[i].re = a[2*i].re;

		   ao[i].im = a[2*i+1].im;
		   ao[i].re = a[2*i+1].re;

	}
	
	ye = recursive_FFT(ae, n/2);
	yo = recursive_FFT(ao, n/2);

	for(int k = 0; k < (n/2) ; k++){
		if(opt == 0){
					w.re = cos(2.0*pi*k/n); 
		w.im = sin(2.0*pi*k/n);
		}
		else{
					w.re = cos(2.0*pi*k/n); 
		w.im = -sin(2.0*pi*k/n);
		}

		y[k].re = ye[k].re + (w.re * yo[k].re - w.im * yo[k].im);
		y[k].im = ye[k].im + (w.im * yo[k].re + w.re * yo[k].im);
		y[k + (n/2)].re = ye[k].re - (w.re * yo[k].re - w.im * yo[k].im);
		y[k + (n/2)].im = ye[k].im - (w.im * yo[k].re + w.re * yo[k].im);
	
	}
	return y;
}

int main(){
	int n, k;
	scanf("%d %d ",&opt,&n);
	double p,q;

		struct comp a[n];
		struct comp* h;
		for(k = 0; k<n; k++){
			scanf("%lf %lf",&a[k].re,&a[k].im);
		}
		h = recursive_FFT(a,n);

		printf("%d", n);
		for(k = 0; k<n; k++){
			if(opt ==0)
			p = (h[k].re), q = (h[k].im);
			else
			p = (h[k].re)/n, q = (h[k].im)/n;
			if((abs(p) == 0.00)&&(abs(q) == 0.00)){
			printf(" %d %d",0,0);
			continue;
		}
			if(abs(p) == 0.00)
			printf(" %d %.1lf",0,q);
			else if(abs(q) == 0.00)
			printf(" %.1lf %d",p,0);
			else
			printf(" %.1lf %.1lf",p,q);
			
		}	
	
//	else{
//		struct comp a[n];
//		struct comp* g;
//		for(k = 0; k<n; k++){
//			scanf("%d %d",&a[k].re,&a[k].im);
//		}
//		//y = recursive_FFTinv(a,n);
//	}

	return 0;
}
