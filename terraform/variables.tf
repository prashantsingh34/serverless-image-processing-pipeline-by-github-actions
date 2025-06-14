variable "env"{
    type= string
    description= "The env in which code is running, branch name, stagig and prod"
}

variable "layer_arn"{
    type= string
    description= "python dependency layer arn"   
}