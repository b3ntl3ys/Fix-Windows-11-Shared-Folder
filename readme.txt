
Enable insecure guest logons
Set-SmbClientConfiguration -EnableInsecureGuestLogons $true -Force
What it does

This allows the Windows SMB client (your computer connecting to shares) to access network shares without authentication.

Enables guest access to SMB shares.

No username or password required.

Often required for old NAS devices or routers.

Example scenario

If a network share allows:

\\192.168.1.10\Public

with no login, Windows normally blocks it for security.
This command allows Windows to connect.

Security risk

Guest access can allow:

Unauthorized access

Malware spreading across networks

2️⃣ Disable SMB security signing (client)
Set-SmbClientConfiguration -RequireSecuritySignature $false -Force
What it does

This tells your SMB client that signed SMB packets are NOT required.

SMB signing normally:

Cryptographically signs packets

Prevents man-in-the-middle attacks

Setting this to false means:

✔ The client can connect to servers that do not support SMB signing.

Why someone uses this

Some older devices or NAS systems don't support SMB signing.

3️⃣ Disable SMB security signing (server)
Set-SmbServerConfiguration -RequireSecuritySignature $false -Force
What it does

This tells your Windows computer acting as a server that it does NOT require signed SMB connections from clients.

Meaning:

Other devices can connect without SMB signing enabled.

Example

A very old device connects to your Windows share:

\\YourComputer\SharedFolder

Without this change, Windows may refuse the connection.