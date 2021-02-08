# Quickstart Guide

## Acquaintance

1. You can download and install the free-trial 1C:Enterprise from [1C:Enterprise Developer Network](https://1c-dn.com/).
2. If you are new in 1C:Enterprise world, please see the [1C Engineer Training course](https://www.youtube.com/watch?v=7y42OW5QGec&list=PLhwgyD6RxHxiLvyyH7FJfZwnHd0LutLx1) first.
3. You can download the [last release of Open Subsystems Library](https://github.com/zeegin/OpenSubsystemsLibrary/releases), install it, open in Designer and start to develop your awesome application.

## Ok, I want to contribute

1. Be sure that you are ready to contribute. See [1C Junior Developer Training course](https://www.youtube.com/watch?v=NJF0_zUBHYo&list=PLhwgyD6RxHxh21KkMLtuvUaziCn8TRkmC).
2. You must have a 1C:Enterprise license. After you purchase the licenses you will be available to download [1C:Enterprise Development Tools](https://1c-dn.com/user/updates/1c_enterprise_development_tools/).
3. Install EDT plugins ([video instruction](https://www.youtube.com/watch?v=2rro6MFjh2s&feature=youtu.be)) from the following repositories:
```
http://capralow.ru/edt/unit.launcher/latest/
http://capralow.ru/edt/bslls.validator/latest/
```

4. Clone this project:
    - Open **EDT** and select a new workspace.
    - Close a welcome page: click **Get started**.
    - Click **Import project...** in the left sidebar.
    - Select **Git** and **Project from Git**, click **Next >**.
    - Select **Clone URI** and click **Next >**.
    - Insert `https://github.com/zeegin/OpenSubsystemsLibrary.git` into the **URI** field, click **Next >**.
    - Check that the **master** checkbox is checked and click **Next >**.
    - Chose the directory to store the git repository local copy and click **Next >**.
    - Wait until the project is loaded and click **Next >**.
    - Click **Finish**.

5. First build and run application:
    - Right-click on `OpenSubsystemsLibrary` project.
    - Click **Run As** and click **1C:Enterprise thin client**.
    - Select the infobase or create a new one (Waring! if you select the existing infobase, you can lost your data).
    - Change the access type to **Infobase**.
    - Select a platform to **<8.3.16>**.
    - Click **OK**.

6. Run unit tests:
    - Right-click on `OpenSubsystemsLibrary.Tests` project.
    - Click **Debug As** and click **1C:Enterprise Unit tests**.
    - Wait until tests are passed.
