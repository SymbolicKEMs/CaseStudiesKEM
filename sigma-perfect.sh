#!/usr/bin/env bash
#
python3 get_minimal_binding.py Sigma_Zero/Sigma_Perfect.spthy "Implicit_Key_Authentication_Initiator" &&
python3 get_minimal_binding.py Sigma_Zero/Sigma_Perfect.spthy "Implicit_Key_Authentication_Initiator" --mal   
