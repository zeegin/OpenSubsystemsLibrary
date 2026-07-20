# Quickstart Guide

## Acquaintance

1. You can download and install the free-trial 1C:Enterprise from [1C:Enterprise Developer Network](https://1c-dn.com/).
2. If you are new in 1C:Enterprise world, please see the [1C Engineer Training course](https://www.youtube.com/watch?v=7y42OW5QGec&list=PLhwgyD6RxHxiLvyyH7FJfZwnHd0LutLx1) first.
3. You can download the [last release of Open Subsystems Library](https://github.com/zeegin/OpenSubsystemsLibrary/releases), install it, open in Designer and start to develop your awesome application.

## Ok, I want to contribute

1. Be sure that you are ready to contribute. See [1C Junior Developer Training course](https://www.youtube.com/watch?v=NJF0_zUBHYo&list=PLhwgyD6RxHxh21KkMLtuvUaziCn8TRkmC).
2. Install a licensed [1C:Enterprise](https://1c-dn.com) platform 8.3.27.2074 or later.
3. Clone the repository:

   ```bash
   git clone https://github.com/zeegin/OpenSubsystemsLibrary.git
   cd OpenSubsystemsLibrary
   ```

4. Create an empty infobase and open it in Designer 8.3.27.
5. Select **Configuration > Load configuration from files...** and choose `OpenSubsystemsLibrary/src`.
6. Update the database configuration when Designer prompts you.
7. Open **Configuration extensions**, create an extension named `Tests`, select **Load configuration from files...**, and choose `OpenSubsystemsLibrary.Tests/src`.
8. Verify that the `Tests` extension can be applied, then run the application in thin-client mode.
9. Run the Vanessa Automation feature files from `OpenSubsystemsLibrary.Tests/features`.

Both source trees use the hierarchical Designer XML format. The configuration and the test extension use compatibility mode 8.3.27.
