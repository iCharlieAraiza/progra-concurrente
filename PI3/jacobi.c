#include <omp.h>
#include <cmath>
#include <stdio.h>
#include <time.h>

#define ITERATION_LIMIT 333
#define EPSILON 0.0000001
#define NUM_OF_THREADS 4

bool check_diagoanally_dominant_sequential(float** matrix, int matriz_tamano);
bool check_diagoanally_dominant_parallel(float** matrix, int matriz_tamano);
void solve_jacobi_sequential(float** matrix, int matriz_tamano, float* right_hand_side);
void jacovi_paralelo(float** matrix, int matriz_tamano, float* right_hand_side);
void init_array_sequential(float array[], int array_size);
float* clone_array_sequential(float array[], int array_length);
void init_array_parallel(float array[], int array_size);
float* clone_array_parallel(float array[], int array_length);
void delete_matrix(float** matrix, int matriz_tamano);

int main(){

    int matriz_tamano, it;
    printf("Escribe el tamaño de la matriz: ");
    scanf_s("%d", &matriz_tamano);
    
    printf("Escribe el número de iteraciones: ");
    scanf_s("%d", &it);

    float** matrix = new float*[matriz_tamano];
    for (int i = 0; i < matriz_tamano; i++) matrix[i] = new float[matriz_tamano];
    float* right_hand_side = new float[matriz_tamano];

    printf("Escribe los coeficientes:\n");
    for (int i = 0; i < matriz_tamano; i++){
        printf("Fila #%d elementos:------\n", i);
        for (int j = 0; j < matriz_tamano; j++) {
            printf("Matrix[%d][%d]:\n", i, j);
            scanf_s("%f", &matrix[i][j]);
        }
    }

    omp_set_num_threads(NUM_OF_THREADS);
    if (!check_diagoanally_dominant_parallel(matrix, matriz_tamano)){
        printf("La matriz no es dominante, por favor agrega otra matriz.\n");
        delete_matrix(matrix, matriz_tamano);
        delete[] right_hand_side;
        printf("Quieres continuar? 1/0\n");
        scanf_s("%d", &user_choice);
        continue;
    }

    // Allowing the user to enter the RHS .. 
    printf("Escribe el vector B");
    for (int i = 0; i < matriz_tamano; i++){
        printf("Element #%d\n", i);
        scanf_s("%f", &right_hand_side[i]);
    }

    //Ejecución concurrente

    const clock_t parallel_starting_time = clock();
    omp_set_num_threads(NUM_OF_THREADS);
    jacovi_paralelo(matrix, matriz_tamano, right_hand_side);
    printf("Tiempo transcurrido: %f ms\n", float(clock() - parallel_starting_time));

    // Liberar matriz
    delete_matrix(matrix, matriz_tamano);
    delete[] right_hand_side;

}

bool check_diagoanally_dominant_parallel(float** matrix, int matriz_tamano){
	// This is to validate that all the rows applies the rule .. 
	int check_count = 0;
	#pragma omp parallel 
	{
		// For each row
		// Each thread will be assigned to run on a row.
		#pragma omp for schedule (guided, 1)
		for (int i = 0; i < matriz_tamano; i++){
			float row_sum = 0;
			// Summing the other row elements .. 
			for (int j = 0; j < matriz_tamano; j++) {
				if (j != i) row_sum += abs(matrix[i][j]);
			}

			if (abs(matrix[i][i]) >= row_sum){
				#pragma omp atomic 
				check_count++;
			}
		}
	}
	return check_count == matriz_tamano;
}

bool check_diagoanally_dominant_sequential(float** matrix, int matriz_tamano){
	int check_count = 0;
	for (int i = 0; i < matriz_tamano; i++) {
		float row_sum = 0;
		for (int j = 0; j < matriz_tamano; j++) {
			if (j != i) row_sum += abs(matrix[i][j]);
		}

		if (abs(matrix[i][i]) >= row_sum) {
			check_count++;
		}
	}
	return check_count == matriz_tamano;
}


void jacovi_paralelo(float** matrix, int matriz_tamano, float* right_hand_side) {
	float* solcuion = new float[matriz_tamano];
	float* last_iteration = new float[matriz_tamano];
	
    init_array_parallel(solucion, matriz_tamano); 
	for (int i = 0; i < it; i++){
		last_iteration = clone_array_parallel(solucion, matriz_tamano);
		
		#pragma omp parallel for schedule(dynamic, 1)
		for (int j = 0; j < matriz_tamano; j++){
			float sigma_value = 0;
			for (int k = 0; k < matriz_tamano; k++){
				if (j != k) {
					sigma_value += matrix[j][k] * solucion[k];
				}
			}
			solucion[j] = (right_hand_side[j] - sigma_value) / matrix[j][j];
		}

		int parar_count = 0;
		#pragma omp parallel for schedule(dynamic, 1) 
		for (int s = 0; s < matriz_tamano; s++) {
			if (abs(last_iteration[s] - solucion[s]) <= EPSILON) {
				#pragma atomic
				parar_count++;
			}
		}

		if (parar_count == matriz_tamano) break;

		printf("Iteration #%d: ", i+1);
		for (int l = 0; l < matriz_tamano; l++) {
			printf("%f ", solucion[l]);
		}
		printf("\n");
	}
}

void init_array_sequential(float array[], int array_size){
	for (int i = 0; i < array_size; i++) {
		array[i] = 0;
	}
}

float* clone_array_sequential(float array[], int array_length){
	float* output = new float[array_length];
	for (int i = 0; i < array_length; i++) {
		output[i] = array[i];
	}
	return output;
}

void init_array_parallel(float array[], int array_size){
	#pragma omp parallel for schedule (dynamic, 1)
	for (int i = 0; i < array_size; i++) {
		array[i] = 0;
	}
}

float* clone_array_parallel(float array[], int array_length){
	float* output = new float[array_length];
	#pragma omp parallel for schedule (dynamic, 1)
	for (int i = 0; i < array_length; i++) {
		output[i] = array[i];
	}
	return output;
}

void delete_matrix(float** matrix, int matriz_tamano) {
	for (int i = 0; i < matriz_tamano; i++) {
		delete[] matrix[i];
	}
	delete[] matrix;
}
