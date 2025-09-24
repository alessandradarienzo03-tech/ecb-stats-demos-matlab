%% Kalman Filter Demo (Discrete-Time, Toy System)
% Basic state estimation for a 2D linear system with process and measurement noise.
% Shows: simulation, prediction-update cycle, covariance propagation, and error plots.
% Author: Alessandra D'Arienzo

clear
clc
close all
T = 100;

% definisco le matrici del modello
A = [1 1; 0 0.9];
B = [0 1]';
C = [1 0];

% inizializzo il vettore di stato del sistema e dell'osservatore
x = zeros(2,T);
x_hat = zeros(2,T);
y = zeros(1,T);
y_hat = zeros(1,T);

% definisco le condizioni iniziali
x(:,1) = randn(2,1);
y(1) = C*x(:,1)+randn(1);

% definisco l'oggetto ss da fornire al comando Kalman
SYS = ss(A,[B eye(2)],C,[],1)
% definisco la matrice di covarianza del rumore di processo
QN = 0.1^2*eye(2)
% calcolo il guadagno del filtro asintotico
[KEST,L,P,M] = kalman(SYS,QN,1,[])
% calcolo la stima al primo istante
x_hat(:,1) = M*(y(1));

cov_err = eye(2);
my_gain = cov_err*C'*(C*cov_err*C'+1)^(-1)

for kk = 1:T


    % definisco l'ingresso del sistema
    u(kk) = 1;
    % simulo la dinamica del sistema
    x(:,kk+1) = A*x(:,kk)+B*u(kk)+ 0.1*randn(2,1);
    y(kk+1) = C*x(:,kk+1)+randn(1);
    
    % calcolo la predizione un passo avanti
    x_hat(:,kk+1) = A*x_hat(:,kk)+B*u(kk);
    % ciò mi consente di calcolare la stima di y_k sulla base delle y
    % precedenti
    y_hat(kk+1) = C*x_hat(:,kk+1);
    % e infine aggiorno la stima grazie alla variabile innovazione
    x_hat(:,kk+1) = x_hat(:,kk+1) + 0*(y(kk+1)-y_hat(kk+1));
    %x_hat(:,kk+1) = x_hat(:,kk+1) + my_gain(:,kk)*(y(kk+1)-y_hat(kk+1));

    cov_one_step(:,:,kk+1) = A*cov_err(:,:,kk)*A'+QN;
    cov_err(:,:,kk+1) =  cov_one_step(:,:,kk+1) - cov_one_step(:,:,kk+1)*C'*(C*cov_one_step(:,:,kk+1)*C'+1)^(-1)*C*cov_one_step(:,:,kk+1);
    my_gain(:,kk+1) = cov_one_step(:,:,kk+1)*C'*(C*cov_one_step(:,:,kk+1)*C'+1)^(-1);
  
end


plot(x(1,:)-x_hat(1,:))
figure
plot(x(2,:)-x_hat(2,:))



