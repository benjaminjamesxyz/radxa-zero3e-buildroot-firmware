# Managing Users and Groups

This guide explains how to add and manage users and groups in your Buildroot system.

## The Users Table

Buildroot uses a text file to define the users and groups that should be created in the target root filesystem. In this project, this file is located at:

`board/radxa/radxa_zero3e/users.txt`

## File Format

Each line in the file defines a user with the following format:

```text
username uid group gid password home_dir shell groups comment
```

*   **username**: The login name (e.g., `radxa`).
*   **uid**: User ID. Use `-1` to let Buildroot assign one automatically.
*   **group**: The user's primary group name (e.g., `radxa`).
*   **gid**: Group ID. Use `-1` to let Buildroot assign one automatically.
*   **password**: The login password.
    *   **Plaintext:** You can provide a plaintext password (e.g., `secret`). Buildroot will encrypt it during the build.
    *   **Hash:** You can provide a pre-encrypted hash (starting with `$`). This is recommended for consistency.
    *   **No Password:** Use `-` to create a user with no password (account locked/passwordless login depending on config).
*   **home_dir**: The path to the user's home directory (e.g., `/home/radxa`).
*   **shell**: The user's login shell (e.g., `/bin/sh`).
*   **groups**: A comma-separated list of additional groups the user belongs to (e.g., `sudo,audio,video`).
*   **comment**: A description or full name (GECOS field).

## Example: Adding a User

To add a user named `radxa` with the password `radxa123`, belonging to `sudo`, `audio`, and `video` groups:

1.  Open `board/radxa/radxa_zero3e/users.txt`.
2.  Add the following line:

    ```text
    radxa -1 radxa -1 radxa123 /home/radxa /bin/sh sudo,audio,video Radxa User
    ```

## Using Password Hashes (Recommended)

To ensure the password is set exactly as you expect, it is safer to generate the hash on your host machine and paste it into the file.

1.  **Generate the hash:**
    You can use `openssl` to generate a SHA-512 hash:
    ```bash
    openssl passwd -6 "your_password"
    ```

2.  **Update `users.txt`:**
    Replace the plaintext password with the generated hash (it will start with `$6$`).

    ```text
    radxa -1 radxa -1 $6$hash_string... /home/radxa /bin/sh sudo,audio,video Radxa User
    ```

## Enabling the Users Table

This project is already configured to use the custom users table. This is controlled by the `BR2_ROOTFS_USERS_TABLES` setting in the Buildroot configuration.

If you are setting this up from scratch, ensure your `defconfig` contains:

```makefile
BR2_ROOTFS_USERS_TABLES="board/radxa/radxa_zero3e/users.txt"
```
