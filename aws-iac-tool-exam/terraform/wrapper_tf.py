from python_terraform import Terraform

class TerraformWrapper:
    def __init__(self, terraform_dir):
        self.terraform_dir = terraform_dir
        self.tf = None
        self.initialize_terraform()

    def initialize_terraform(self):
        try:
            self.tf = Terraform(working_dir=self.terraform_dir)
        except ImportError as e:
            raise RuntimeError("python-terraform library is not installed. Please install it using 'pip install python-terraform'.") from e

    def init(self):
        try:
            return self.tf.init()
        except Exception as e:
            raise RuntimeError("Failed to initialize Terraform configuration.") from e

    def plan(self):
        try:
            return self.tf.plan()
        except Exception as e:
            raise RuntimeError("Failed to plan Terraform configuration.") from e

    def apply(self):
        try:
            return self.tf.apply(skip_plan=True)
        except Exception as e:
            raise RuntimeError("Failed to apply Terraform configuration.") from e

    def destroy(self):
        try:
            return self.tf.destroy()
        except Exception as e:
            raise RuntimeError("Failed to destroy Terraform resources.") from e

    def get_state(self):
        try:
            return self.tf.show()
        except Exception as e:
            raise RuntimeError("Failed to retrieve Terraform state.") from e

    def get_output(self):
        try:
            return self.tf.output()
        except Exception as e:
            raise RuntimeError("Failed to retrieve Terraform output.") from e