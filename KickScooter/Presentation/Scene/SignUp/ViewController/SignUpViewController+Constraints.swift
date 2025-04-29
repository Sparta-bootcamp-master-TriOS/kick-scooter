extension SignUpViewController {
    func configureScrollViewConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }

        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView)
            $0.bottom.equalTo(signUpButton)
        }
    }

    func configureRiveViewConstraints() {
        riveView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(300)
        }
    }

    func configureTextFieldConstraints() {
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(riveView.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(40)
        }

        idTextField.snp.makeConstraints {
            $0.top.equalTo(invalidNameLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(40)
        }

        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(invalidIDLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(40)
        }

        confirmPasswordTextField.snp.makeConstraints {
            $0.top.equalTo(invalidPasswordLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(40)
        }

        emailTextField.snp.makeConstraints {
            $0.top.equalTo(invalidConfirmPasswordLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(40)
        }
    }

    func configureInvalidLabelConstraints() {
        invalidNameLabel.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(3)
            $0.horizontalEdges.equalToSuperview().inset(40)
        }

        invalidIDLabel.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(3)
            $0.horizontalEdges.equalToSuperview().inset(40)
        }

        invalidPasswordLabel.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(3)
            $0.horizontalEdges.equalToSuperview().inset(40)
        }

        invalidConfirmPasswordLabel.snp.makeConstraints {
            $0.top.equalTo(confirmPasswordTextField.snp.bottom).offset(3)
            $0.horizontalEdges.equalToSuperview().inset(40)
        }

        invalidEmailLabel.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(3)
            $0.horizontalEdges.equalToSuperview().inset(40)
        }
    }

    func configureSignUpButtonConstraints() {
        signUpButton.snp.makeConstraints {
            $0.top.equalTo(invalidEmailLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(40)
        }
    }
}
