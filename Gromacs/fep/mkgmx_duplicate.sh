#!/bin/bash
# 48 Windows
#; init_lambda_state        0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47
#fep-lambdas              = 0 0.000001 0.00001 0.0001 0.001 0.004 0.01 0.02 0.03 0.04 0.05 0.06 0.08 0.1 0.12 0.14 0.18 0.22 0.26 0.30 0.34 0.38 0.42 0.46 0.5 0.54 0.58 0.62 0.66 0.7 0.74 0.78 0.82 0.86 0.88 0.9 0.92 0.94 0.95 0.96 0.97 0.98 0.99 0.996 0.999 0.9999 0.99999 0.999999 1.00
# 24 Windows
#        -e 's/; init_lambda_state.*/; init_lambda_state        0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23/g' \
#        -e 's/^fep-lambdas.*/fep-lambdas              = 0 0.00001 0.0001 0.001 0.01 0.02 0.04 0.06 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 0.94 0.96 0.98 0.99 0.999 0.9999 0.99999 1.00/g' \
# 32 Windows
#        -e 's/; init_lambda_state.*/; init_lambda_state        0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31/g' \
#        -e 's/^fep-lambdas.*/fep-lambdas              = 0 0.00001 0.0001 0.001 0.01 0.02 0.04 0.06 0.1 0.14 0.18 0.22 0.26 0.30 0.34 0.42 0.5 0.58 0.66 0.7 0.74 0.78 0.82 0.86 0.9 0.94 0.96 0.98 0.99 0.999 0.9999 0.99999 1.00/g' \
# 64 Windows
#        -e 's/; init_lambda_state.*/; init_lambda_state        0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63/g' \
#        -e 's/^fep-lambdas.*/fep-lambdas              = 0 0.000001 0.00001 0.0001 0.001 0.002 0.003 0.004 0.005 0.006 0.008 0.01 0.014 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.1 0.12 0.14 0.18 0.22 0.26 0.30 0.34 0.38 0.42 0.46 0.5 0.54 0.58 0.62 0.66 0.7 0.74 0.78 0.82 0.86 0.88 0.9 0.91 0.92 0.93 0.94 0.95 0.96 0.97 0.98 0.986 0.99 0.992 0.994 0.995 0.996 0.997 0.998 0.999 0.9999 0.99999 0.999999 1.00/g' \

if [[ "$#" -ne 1 ]]; then
    echo "Usage: mkgmx_duplicate_mdp [NN]"
    exit 0
fi

START=0
END=$(($1 - 1))

for prefix in em nvt md; do
    sed \
        -e 's/; init_lambda_state.*/; init_lambda_state        0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63/g' \
        -e 's/^fep-lambdas.*/fep-lambdas              = 0 0.000001 0.00001 0.0001 0.001 0.002 0.003 0.004 0.005 0.006 0.008 0.01 0.014 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.1 0.12 0.14 0.18 0.22 0.26 0.30 0.34 0.38 0.42 0.46 0.5 0.54 0.58 0.62 0.66 0.7 0.74 0.78 0.82 0.86 0.88 0.9 0.91 0.92 0.93 0.94 0.95 0.96 0.97 0.98 0.986 0.99 0.992 0.994 0.995 0.996 0.997 0.998 0.999 0.9999 0.99999 0.999999 1.00/g' \
        ${prefix}.mdp > ${prefix}-mod.mdp
done

for ii in $(seq $START $END); do
    echo "mkgmx> Initial Lambda State $ii"
    mkdir -p dir${ii}

    for prefix in em nvt md; do
        sed -e 's/^init_lambda_state.*$/init_lambda_state = '$ii'/g' \
        ${prefix}-mod.mdp > dir${ii}/${prefix}.mdp
    done
done

