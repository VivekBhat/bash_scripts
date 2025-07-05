#!/usr/bin/env python3

import os
import sys

def update_aws_credentials(profile, access_key_id, secret_access_key):
    credentials_file = os.path.expanduser("~/.aws/credentials")

    # Read the existing credentials
    with open(credentials_file, "r") as f:
        lines = f.readlines()

    # Update the specified profile
    for i, line in enumerate(lines):
        if line.strip() == f"[{profile}]":
            lines[i + 1] = f"aws_access_key_id = {access_key_id}\n"
            lines[i + 2] = f"aws_secret_access_key = {secret_access_key}\n"
            break
    else:
        print(f"Profile '{profile}' not found in the credentials file.")
        sys.exit(1)

    # Write the updated credentials back to the file
    with open(credentials_file, "w") as f:
        f.writelines(lines)

    print(f"Credentials updated for the '{profile}' profile.")

if __name__ == "__main__":
    if len(sys.argv) != 4:
        print("Usage: python update_credentials.py <profile> <access_key_id> <secret_access_key>")
        sys.exit(1)

    profile, access_key_id, secret_access_key = sys.argv[1], sys.argv[2], sys.argv[3]
    update_aws_credentials(profile, access_key_id, secret_access_key)
