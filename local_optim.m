function [f] = local_optim(X_start)
    options = {};
    X_end, f = fmincon(objective, X_start, [], [], [], [], [], [], constraints, options);
end