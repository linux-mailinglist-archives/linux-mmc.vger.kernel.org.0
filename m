Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F205A602D25
	for <lists+linux-mmc@lfdr.de>; Tue, 18 Oct 2022 15:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiJRNiY (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 18 Oct 2022 09:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJRNiX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Oct 2022 09:38:23 -0400
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B1FCC819
        for <linux-mmc@vger.kernel.org>; Tue, 18 Oct 2022 06:38:17 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.savoirfairelinux.com (Postfix) with ESMTP id 1109B9C076E;
        Tue, 18 Oct 2022 09:38:16 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
        by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id hkwvOvjoimAG; Tue, 18 Oct 2022 09:38:13 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.savoirfairelinux.com (Postfix) with ESMTP id D7C7B9C078B;
        Tue, 18 Oct 2022 09:38:12 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com D7C7B9C078B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
        t=1666100292; bh=2p+qbPMb5kvCR2vOFM9o/l7+0NOehMW1OOrcdnkPZkY=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=Lqx9ZJSZyi6Oy5Qg1AfEc8GX09ms/hBCxh9vS6DoQpooyH84LZXdBuRiTQmHEwaCc
         1P8NWJxcOXsDBMKrDuXsWpx6im+ur3Lrifq0hlML61LFrkYI3fwIoCrTX41Lr1OTGi
         O2nXrs78jkRFBM4wb+MN+1O/q7P+7itrlvfx5gE15LsnOEkAEm4etZw3iw+Cvy9+yQ
         qJt8Mldl09GrPzLqUADGYKfD+vAaonSbVNuFJ5p6DeBwwJQHCg2TiYqSX+Gn2g8III
         PLnx4cFRsx3wrYV1pEdj09cPySaRQSsJHZsjCz7JpUiDI6Y1VqjBmb5OPNRgkvStFK
         Ewdf1tKwzWYtg==
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
        by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id THfjEpIuOUot; Tue, 18 Oct 2022 09:38:12 -0400 (EDT)
Received: from barbarian.mtl.sfl (barbarian.mtl.sfl [192.168.48.98])
        by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 941279C076E;
        Tue, 18 Oct 2022 09:38:12 -0400 (EDT)
From:   Firas Ashkar <firas.ashkar@savoirfairelinux.com>
To:     alex@digriz.org.uk, ulf.hansson@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        Firas Ashkar <firas.ashkar@savoirfairelinux.com>
Subject: [PATCH] mmc: add TS7800 FPGA based MMC controller driver
Date:   Tue, 18 Oct 2022 09:38:00 -0400
Message-Id: <20221018133800.10636-1-firas.ashkar@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

add standard mmc/host controller driver for TS-7800v1, instead of the
original block based 'tssdcore' driver provided by EmbeddedTS linux-2.6.x
code base.

$ cat /proc/cpuinfo
processor	: 0
model name	: Feroceon rev 0 (v5l)
BogoMIPS	: 333.33
Features	: swp half thumb fastmult edsp
CPU implementer	: 0x41
CPU architecture: 5TEJ
CPU variant	: 0x0
CPU part	: 0x926
CPU revision	: 0

Hardware	: Technologic Systems TS-78xx SBC
Revision	: 0000
Serial		: 0000000000000000
$

$ uname -a
Linux ts-7800 6.1.0-rc1 #3 PREEMPT Mon Oct 17 15:58:49 EDT 2022 armv5tel =
GNU/Linux
$

$ lsmod
Module                  Size  Used by    Not tainted
$

$ fdisk -lu
mtdblock: MTD device 'mbr' is NAND, please consider using UBI block devic=
es instead.
mtdblock: MTD device 'kernel' is NAND, please consider using UBI block de=
vices instead.
mtdblock: MTD device 'initrd' is NAND, please consider using UBI block de=
vices instead.
mtdblock: MTD device 'rootfs' is NAND, please consider using UBI block de=
vices instead.
$

$ cat /proc/iomem
00000000-07ffffff : System RAM
  00008000-00978fff : Kernel code
  00d68000-00e9cf97 : Kernel data
e8000044-e8000047 : timeriomem_rng
  e8000044-e8000047 : timeriomem_rng timeriomem_rng
e8000100-e80001ff : ts_sdmmc_ctrl
e8000200-e80002ff : ts_irqc
  e8000200-e80002ff : ts7800-irqc ts_irqc
e8000400-e80004ff : ts_dmac
  e8000400-e80004ff : ts7800-dmac ts_dmac
e8000804-e8000807 : gen_nand
  e8000804-e8000807 : gen_nand gen_nand
e8000808-e8000808 : rtc-m48t86
  e8000808-e8000808 : rtc-m48t86 rtc-m48t86
e800080c-e800080c : rtc-m48t86
  e800080c-e800080c : rtc-m48t86 rtc-m48t86
f1012000-f10120ff : serial8250.0
  f1012000-f101201f : serial
f1012100-f10121ff : serial8250.1
  f1012100-f101211f : serial
f1020108-f102010b : orion_wdt
f1020300-f1020303 : orion_wdt
f1020400-f102040f : ts_bridge
  f1020400-f102040f : ts7800-irqc ts_bridge
f1050000-f1050fff : orion-ehci.0
  f1050000-f1050fff : orion-ehci.0 orion-ehci.0
f1060900-f10609ff : xor 0 low
f1060b00-f1060bff : xor 0 high
f1072000-f1075fff : ge00 base
  f1072004-f1072087 : ge00 mvmdio base
f1080000-f1084fff : sata base
f1090000-f109ffff : regs
  f1090000-f109ffff : mv_crypto regs
f10a0000-f10a0fff : orion-ehci.1
  f10a0000-f10a0fff : orion-ehci.1 orion-ehci.1
f2200000-f2201fff : sram
  f2200000-f2201fff : mv_crypto sram
$

$ modprobe ts7800v1_sdmmc
ts7800v1_sdmmc ts7800v1_sdmmc: Detected SDCoreV2
ts7800v1_sdmmc ts7800v1_sdmmc: TS-7800v1 FPGA based SD/MMC Controller ini=
tialized
mmc0: new high speed SDHC card at address e624
mmcblk0: mmc0:e624 SU08G 7.40 GiB
 mmcblk0: p1 p2 p3

$

$ fdisk -lu
mtdblock: MTD device 'mbr' is NAND, please consider using UBI block devic=
es instead.
mtdblock: MTD device 'kernel' is NAND, please consider using UBI block de=
vices instead.
mtdblock: MTD device 'initrd' is NAND, please consider using UBI block de=
vices instead.
mtdblock: MTD device 'rootfs' is NAND, please consider using UBI block de=
vices instead.
Disk /dev/mmcblk0: 7580 MB, 7948206080 bytes, 15523840 sectors
242560 cylinders, 4 heads, 16 sectors/track
Units: sectors of 1 * 512 =3D 512 bytes

Device       Boot StartCHS    EndCHS        StartLBA     EndLBA    Sector=
s  Size Id Type
/dev/mmcblk0p1    0,0,2       8,40,33              1     131072     13107=
2 64.0M da Unknown
/dev/mmcblk0p2    8,40,34     8,157,42        131073     138452       738=
0 3690K da Unknown
/dev/mmcblk0p3    8,157,43    73,226,46       138453    1187028    104857=
6  512M 83 Linux
$

$ cat /proc/iomem
00000000-07ffffff : System RAM
  00008000-00978fff : Kernel code
  00d68000-00e9cf97 : Kernel data
e8000044-e8000047 : timeriomem_rng
  e8000044-e8000047 : timeriomem_rng timeriomem_rng
e8000100-e80001ff : ts_sdmmc_ctrl
  e8000100-e80001ff : ts7800v1_sdmmc ts_sdmmc_ctrl
e8000200-e80002ff : ts_irqc
  e8000200-e80002ff : ts7800-irqc ts_irqc
e8000400-e80004ff : ts_dmac
  e8000400-e80004ff : ts7800-dmac ts_dmac
e8000804-e8000807 : gen_nand
  e8000804-e8000807 : gen_nand gen_nand
e8000808-e8000808 : rtc-m48t86
  e8000808-e8000808 : rtc-m48t86 rtc-m48t86
e800080c-e800080c : rtc-m48t86
  e800080c-e800080c : rtc-m48t86 rtc-m48t86
f1012000-f10120ff : serial8250.0
  f1012000-f101201f : serial
f1012100-f10121ff : serial8250.1
  f1012100-f101211f : serial
f1020108-f102010b : orion_wdt
f1020300-f1020303 : orion_wdt
f1020400-f102040f : ts_bridge
  f1020400-f102040f : ts7800-irqc ts_bridge
f1050000-f1050fff : orion-ehci.0
  f1050000-f1050fff : orion-ehci.0 orion-ehci.0
f1060900-f10609ff : xor 0 low
f1060b00-f1060bff : xor 0 high
f1072000-f1075fff : ge00 base
  f1072004-f1072087 : ge00 mvmdio base
f1080000-f1084fff : sata base
f1090000-f109ffff : regs
  f1090000-f109ffff : mv_crypto regs
f10a0000-f10a0fff : orion-ehci.1
  f10a0000-f10a0fff : orion-ehci.1 orion-ehci.1
f2200000-f2201fff : sram
  f2200000-f2201fff : mv_crypto sram
$

$ mkfs.ext4 -L misc /dev/mmcblk0p3
mke2fs 1.46.5 (30-Dec-2021)
Discarding device blocks: done
Creating filesystem with 131072 4k blocks and 32768 inodes
Filesystem UUID: d5acd725-a775-4e92-81a3-3fdf28880884
Superblock backups stored on blocks:
	32768, 98304

Allocating group tables: done
Writing inode tables: done
Creating journal (4096 blocks): done
Writing superblocks and filesystem accounting information: done

$

$ mount -o sync /dev/mmcblk0p3 /mnt/
EXT4-fs (mmcblk0p3): mounted filesystem with ordered data mode. Quota mod=
e: disabled.
$
$ mount
rootfs on / type rootfs (rw,size=3D55424k,nr_inodes=3D13856)
proc on /proc type proc (rw,relatime)
devpts on /dev/pts type devpts (rw,relatime,gid=3D5,mode=3D620,ptmxmode=3D=
666)
tmpfs on /dev/shm type tmpfs (rw,relatime,mode=3D777)
tmpfs on /tmp type tmpfs (rw,relatime)
tmpfs on /run type tmpfs (rw,nosuid,nodev,relatime,mode=3D755)
sysfs on /sys type sysfs (rw,relatime)
/dev/mmcblk0p3 on /mnt type ext4 (rw,sync,relatime)
$

$ ls -lsrt /mnt/
total 16
    16 drwx------    2 root     root         16384 Oct 17 20:12 lost+foun=
d
$

$ time cp /lib/libc.so.6 /mnt/
real	0m 1.48s
user	0m 0.01s
sys	0m 0.07s
$

$ ls -lsrt /mnt/
total 1436
    16 drwx------    2 root     root         16384 Oct 17 20:12 lost+foun=
d
  1420 -rwxr-xr-x    1 root     root       1450164 Oct 17 20:14 libc.so.6
$

$ sha512sum /mnt/libc.so.6
b7e088bb52ebff255d1e19425513324322b28c0834cf89393daa96f725e19b19650c3a3f5=
29659986323b1a52882131554f0669ba4749e8ccdfc877b11763dbf  /mnt/libc.so.6
$

$ sha512sum /lib/libc.so.6
b7e088bb52ebff255d1e19425513324322b28c0834cf89393daa96f725e19b19650c3a3f5=
29659986323b1a52882131554f0669ba4749e8ccdfc877b11763dbf  /lib/libc.so.6
$

$ sync
$ umount /mnt/
EXT4-fs (mmcblk0p3): unmounting filesystem.
$

Signed-off-by: Firas Ashkar <firas.ashkar@savoirfairelinux.com>
---
:100644 100644 2f4fe3ca5c1a b4dad5b2921d M	arch/arm/mach-orion5x/ts78xx-f=
pga.h
:100644 100644 af810e7ccd79 8b98395359e4 M	arch/arm/mach-orion5x/ts78xx-s=
etup.c
:100644 100644 f324daadaf70 62b7f9a977ea M	drivers/mmc/host/Kconfig
:100644 100644 4e4ceb32c4b4 34e19d3be7d0 M	drivers/mmc/host/Makefile
:000000 100644 000000000000 b63089f8b9a1 A	drivers/mmc/host/ts7800v1_sdmm=
c.c
 arch/arm/mach-orion5x/ts78xx-fpga.h  |    1 +
 arch/arm/mach-orion5x/ts78xx-setup.c |   54 +
 drivers/mmc/host/Kconfig             |   10 +
 drivers/mmc/host/Makefile            |    1 +
 drivers/mmc/host/ts7800v1_sdmmc.c    | 2301 ++++++++++++++++++++++++++
 5 files changed, 2367 insertions(+)

diff --git a/arch/arm/mach-orion5x/ts78xx-fpga.h b/arch/arm/mach-orion5x/=
ts78xx-fpga.h
index 2f4fe3ca5c1a..b4dad5b2921d 100644
--- a/arch/arm/mach-orion5x/ts78xx-fpga.h
+++ b/arch/arm/mach-orion5x/ts78xx-fpga.h
@@ -31,6 +31,7 @@ struct fpga_devices {
 	/* Technologic Systems */
 	struct fpga_device	ts_rtc;
 	struct fpga_device	ts_nand;
+	struct fpga_device	ts_sdmmc;
 	struct fpga_device	ts_rng;
 };
=20
diff --git a/arch/arm/mach-orion5x/ts78xx-setup.c b/arch/arm/mach-orion5x=
/ts78xx-setup.c
index af810e7ccd79..8b98395359e4 100644
--- a/arch/arm/mach-orion5x/ts78xx-setup.c
+++ b/arch/arm/mach-orion5x/ts78xx-setup.c
@@ -279,6 +279,48 @@ static void ts78xx_ts_nand_unload(void)
 	platform_device_del(&ts78xx_ts_nand_device);
 }
=20
+/***********************************************************************=
******
+ * SD/MMC Host controller
+ ***********************************************************************=
*****/
+#define TS_SDMMC_CTRL (TS78XX_FPGA_REGS_PHYS_BASE + 0x100)
+#define TS_SDMMC_SDBUSY 0x41
+
+static struct resource ts78xx_ts_sdmmc_resources[] =3D {
+	DEFINE_RES_MEM_NAMED(TS_SDMMC_CTRL, 0x100, "ts_sdmmc_ctrl"),
+	DEFINE_RES_IRQ_NAMED(TS_SDMMC_SDBUSY, "ts_sdmmc_sdbusy"),
+};
+
+static struct platform_device ts78xx_ts_sdmmc_device =3D {
+	.name =3D "ts7800v1_sdmmc",
+	.id =3D -1,
+	.resource =3D ts78xx_ts_sdmmc_resources,
+	.num_resources =3D ARRAY_SIZE(ts78xx_ts_sdmmc_resources),
+};
+
+static int ts78xx_ts_sdmmc_load(void)
+{
+	int rc;
+
+	if (ts78xx_fpga.supports.ts_sdmmc.init =3D=3D 0) {
+		rc =3D platform_device_register(&ts78xx_ts_sdmmc_device);
+		if (!rc)
+			ts78xx_fpga.supports.ts_sdmmc.init =3D 1;
+	} else {
+		rc =3D platform_device_add(&ts78xx_ts_sdmmc_device);
+	}
+
+	if (rc)
+		pr_info("SD/MMC host controller could not be registered: %d\n",
+			rc);
+
+	return rc;
+}
+
+static void ts78xx_ts_sdmmc_unload(void)
+{
+	platform_device_del(&ts78xx_ts_sdmmc_device);
+}
+
 /***********************************************************************=
******
  * HW RNG
  ***********************************************************************=
*****/
@@ -329,6 +371,7 @@ static void ts78xx_fpga_devices_zero_init(void)
 {
 	ts78xx_fpga.supports.ts_rtc.init =3D 0;
 	ts78xx_fpga.supports.ts_nand.init =3D 0;
+	ts78xx_fpga.supports.ts_sdmmc.init =3D 0;
 	ts78xx_fpga.supports.ts_rng.init =3D 0;
 }
=20
@@ -347,6 +390,7 @@ static void ts78xx_fpga_supports(void)
 	case TS7800_REV_9:
 		ts78xx_fpga.supports.ts_rtc.present =3D 1;
 		ts78xx_fpga.supports.ts_nand.present =3D 1;
+		ts78xx_fpga.supports.ts_sdmmc.present =3D 1;
 		ts78xx_fpga.supports.ts_rng.present =3D 1;
 		break;
 	default:
@@ -357,11 +401,13 @@ static void ts78xx_fpga_supports(void)
 				ts78xx_fpga.id & 0xff);
 			ts78xx_fpga.supports.ts_rtc.present =3D 1;
 			ts78xx_fpga.supports.ts_nand.present =3D 1;
+			ts78xx_fpga.supports.ts_sdmmc.present =3D 1;
 			ts78xx_fpga.supports.ts_rng.present =3D 1;
 			break;
 		default:
 			ts78xx_fpga.supports.ts_rtc.present =3D 0;
 			ts78xx_fpga.supports.ts_nand.present =3D 0;
+			ts78xx_fpga.supports.ts_sdmmc.present =3D 0;
 			ts78xx_fpga.supports.ts_rng.present =3D 0;
 		}
 	}
@@ -383,6 +429,12 @@ static int ts78xx_fpga_load_devices(void)
 			ts78xx_fpga.supports.ts_nand.present =3D 0;
 		ret |=3D tmp;
 	}
+	if (ts78xx_fpga.supports.ts_sdmmc.present =3D=3D 1) {
+		tmp =3D ts78xx_ts_sdmmc_load();
+		if (tmp)
+			ts78xx_fpga.supports.ts_sdmmc.present =3D 0;
+		ret |=3D tmp;
+	}
 	if (ts78xx_fpga.supports.ts_rng.present =3D=3D 1) {
 		tmp =3D ts78xx_ts_rng_load();
 		if (tmp)
@@ -400,6 +452,8 @@ static int ts78xx_fpga_unload_devices(void)
 		ts78xx_ts_rtc_unload();
 	if (ts78xx_fpga.supports.ts_nand.present =3D=3D 1)
 		ts78xx_ts_nand_unload();
+	if (ts78xx_fpga.supports.ts_sdmmc.present =3D=3D 1)
+		ts78xx_ts_sdmmc_unload();
 	if (ts78xx_fpga.supports.ts_rng.present =3D=3D 1)
 		ts78xx_ts_rng_unload();
=20
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index f324daadaf70..62b7f9a977ea 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -709,6 +709,16 @@ config MMC_TMIO
 	  This provides support for the SD/MMC cell found in TC6393XB,
 	  T7L66XB and also HTC ASIC3
=20
+config MMC_TS7800
+	tristate "EmbeddedTS 7800v1 FPGA based MMC Controller"
+	depends on MACH_TS78XX
+	help
+	  This provides support for EmbeddedTS MMC core on TS-7800-V1 platform,
+	  only standard MMC SLOT1 is supported.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ts7800v1_sdmmc.
+
 config MMC_SDHI
 	tristate "Renesas SDHI SD/SDIO controller support"
 	depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 4e4ceb32c4b4..34e19d3be7d0 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_MMC_S3C)   	+=3D s3cmci.o
 obj-$(CONFIG_MMC_SDRICOH_CS)	+=3D sdricoh_cs.o
 obj-$(CONFIG_MMC_TMIO)		+=3D tmio_mmc.o
 obj-$(CONFIG_MMC_TMIO_CORE)	+=3D tmio_mmc_core.o
+obj-$(CONFIG_MMC_TS7800)	+=3D ts7800v1_sdmmc.o
 obj-$(CONFIG_MMC_SDHI)		+=3D renesas_sdhi_core.o
 obj-$(CONFIG_MMC_SDHI_SYS_DMAC)		+=3D renesas_sdhi_sys_dmac.o
 obj-$(CONFIG_MMC_SDHI_INTERNAL_DMAC)	+=3D renesas_sdhi_internal_dmac.o
diff --git a/drivers/mmc/host/ts7800v1_sdmmc.c b/drivers/mmc/host/ts7800v=
1_sdmmc.c
new file mode 100644
index 000000000000..b63089f8b9a1
--- /dev/null
+++ b/drivers/mmc/host/ts7800v1_sdmmc.c
@@ -0,0 +1,2301 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * TS-7800 FPGA based SD/MMC host/controller driver
+ *
+ * Copyright (C) 2022 Savoir-faire Linux Inc.
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/ioport.h>
+#include <linux/errno.h>
+#include <linux/dma-mapping.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/clk.h>
+#include <linux/interrupt.h>
+#include <linux/types.h>
+
+#include <linux/mmc/host.h>
+#include <linux/mmc/mmc.h>
+#include <linux/mmc/sd.h>
+
+#include <linux/bitfield.h>
+#include <asm/byteorder.h>
+
+#define DRIVER_NAME "ts7800v1_sdmmc"
+#define SDCORE2_SDCMD_REG 0x8
+#define SDCORE2_SDDATA_REG 0x4
+#define SDCORE2_SDBUS_REG 0xc
+
+#define SD_ACTIVE_SLOT 0x1
+#define NUM_SD_SLOTS 0x2
+#define NUM_MEM_RESOURCES 0x1
+#define MAX_CMD_BYTES 0x6
+#define NORM_RESP_BYTES 0x6
+#define LONG_RESP_BYTES 0x11
+#define BYTE_CLK_CYCLES 0x8
+#define DAT03_NIBBLES_PER_CLK_CYCLE 0x1
+#define BYTE_CYCLES_MASK 0xff
+#define NIBBLE_CLK_CYCLES 0x4
+#define CRC7_CYCLES 0x7
+#define CRC7_CYCLES_MASK 0x7f
+#define CRC16_CYCLES 0x10
+#define CRC16_CYCLES_MASK 0xffff
+#define CRC_POLY 0x1021
+
+#define CMDENB_DATENB_SDCLKL_SDCMDH_SDDAT03L 0x10
+#define CMDENB_DATENB_SDCLKH_SDCMDH_SDDAT03L 0x30
+#define CMDENB_DATENB_SDCLKH_SDCMDH_SDDAT03H 0x3f
+#define CMDENB_DATENB_SDCLKL_SDCMDH_SDDATL 0x10
+#define CMDENB_DATENB_SDCLKL_SDCMDH_SDDAT0L 0x1e
+#define CMDENB_DATENB_SDCLKL_SDCMDH_SDDATH 0x1f
+#define CMDENB_DATENB_SDCLKH_SDCMDH_SDDAT0L 0x3e
+#define CMDTRI_DAT0ENB_SDCLKL_SDCMDH_SDDAT0L 0x5e
+#define CMDTRI_DAT0ENB_SDCLKL_SDCMDH_SDDAT0H 0x5f
+#define CMDTRI_DAT0ENB_SDCLKH_SDCMDH_SDDAT0L 0x7e
+#define CMDTRI_DAT0ENB_SDCLKH_SDCMDH_SDDAT0H 0x7f
+#define CMDENB_DATTRI_SDCLKL_SDCMDL_SDDATH 0x8f
+#define CMDENB_DATTRI_SDCLKH_SDCMDL_SDDATH 0xaf
+#define CMDENB_DATTRI_SDCLKL_SDCMDH_SDDATH 0x9f
+#define CMDENB_DATTRI_SDCLKH_SDCMDH_SDDATH 0xbf
+#define CMDTRI_DATTRI_SDCLKL_SDCMDH_SDDATH 0xdf
+#define CMDTRI_DATTRI_SDCLKH_SDCMDH_SDDATH 0xff
+
+#define DATSSP_4BIT (1 << 5)
+#define SD_HC BIT(6)
+#define SD_MULTI_BLK BIT(7)
+#define SD_LOWSPEED BIT(8)
+#define SD_SELECTED BIT(9)
+#define SD_RESET BIT(10)
+
+#define MAX_RESP_TIMEOUT_MICROSECS 500
+#define MAX_BUSY_TIMEOUT_MICROSECS 5000
+#define MAX_BLK_SIZE 0x200
+#define MAX_BLK_COUNT 0x400
+#define MAX_BLK_SIZE_DWORDS 0x80
+#define MAX_BLK_SIZE_NIBBLES 0x400
+
+/* TS7800v SD/MMC FIFO size */
+#define MAX_SEG_SIZE 0x1000
+#define MAX_SEGS 0x400
+
+enum bit_endianness { LE_ENDIAN, BE_ENDIAN };
+
+struct ts7800v1_sdmmc_slot {
+	bool sd_detect;
+	bool sd_wprot;
+	u32 sd_state;
+	u32 cmd_timeout;
+	u8 *rw_dma_buf;
+	u32 blk_buf_cycle_indx;
+	u32 blk_buf_nibble_indx;
+	int sg_count;
+	u8 response[LONG_RESP_BYTES];
+	u8 cmdptr[MAX_CMD_BYTES];
+};
+
+struct ts7800v1_sdmmc_host {
+	struct mmc_host *mmc_host;
+	unsigned int sdbusy_irq;
+	u8 hw_version;
+	void __iomem *base_iomem;
+	struct mutex mutex_lock;
+	spinlock_t bh_lock;
+	struct ts7800v1_sdmmc_slot sd_slot[NUM_SD_SLOTS];
+};
+
+static inline void add_1readb_delay(struct ts7800v1_sdmmc_host *ts_sdmmc=
_host)
+{
+	readb(ts_sdmmc_host->base_iomem);
+}
+
+static inline void add_2readb_delay(struct ts7800v1_sdmmc_host *ts_sdmmc=
_host)
+{
+	readb(ts_sdmmc_host->base_iomem);
+	readb(ts_sdmmc_host->base_iomem);
+}
+
+static inline void
+add_2clk_cycles_slow(struct ts7800v1_sdmmc_host *ts_sdmmc_host)
+{
+	u8 i;
+
+	for (i =3D 0; i < 2; ++i) {
+		/* toggle low slow clk-line */
+		writeb(CMDTRI_DATTRI_SDCLKL_SDCMDH_SDDATH,
+		       ts_sdmmc_host->base_iomem);
+
+		add_2readb_delay(ts_sdmmc_host);
+
+		/* toggle high slow clk-line */
+		writeb(CMDTRI_DATTRI_SDCLKH_SDCMDH_SDDATH,
+		       ts_sdmmc_host->base_iomem);
+
+		add_2readb_delay(ts_sdmmc_host);
+	}
+}
+
+static inline void
+add_2clk_cycles_high(struct ts7800v1_sdmmc_host *ts_sdmmc_host)
+{
+	u8 i;
+
+	for (i =3D 0; i < 2; ++i) {
+		/* toggle low slow clk-line */
+		writeb(CMDTRI_DATTRI_SDCLKL_SDCMDH_SDDATH,
+		       ts_sdmmc_host->base_iomem);
+
+		add_1readb_delay(ts_sdmmc_host);
+
+		/* toggle high slow clk-line */
+		writeb(CMDTRI_DATTRI_SDCLKH_SDCMDH_SDDATH,
+		       ts_sdmmc_host->base_iomem);
+
+		add_1readb_delay(ts_sdmmc_host);
+	}
+}
+
+static inline u16 ts7800v1_sdmmc_ucrc16(u16 crc_in, u8 incr)
+{
+	u16 xor =3D crc_in >> 15;
+	u16 out =3D crc_in << 1;
+
+	if (incr)
+		out++;
+
+	if (xor)
+		out ^=3D CRC_POLY;
+
+	return out;
+}
+
+static u16 ts7800v1_sdmmc_crc16(const u8 *data, u16 size)
+{
+	u16 crc;
+	u8 i;
+
+	for (crc =3D 0; size > 0; size--, data++)
+		for (i =3D 0x80; i; i >>=3D 1)
+			crc =3D ts7800v1_sdmmc_ucrc16(crc, *data & i);
+
+	for (i =3D 0; i < 16; i++)
+		crc =3D ts7800v1_sdmmc_ucrc16(crc, 0);
+
+	return crc;
+}
+
+static inline u8 ts7800v1_sdmmc_crc7(u8 crc, const u8 *data, size_t len,
+				     enum bit_endianness crc7en)
+{
+	size_t i, lenbe =3D len - 1;
+	u8 ibit, c;
+
+	if (crc7en =3D=3D LE_ENDIAN) {
+		for (i =3D 0; i < len; i++) {
+			c =3D data[i];
+			for (ibit =3D 0; ibit < 8; ibit++) {
+				crc <<=3D 1;
+				if ((c ^ crc) & 0x80)
+					crc ^=3D 0x09;
+
+				c <<=3D 1;
+			}
+
+			crc &=3D 0x7F;
+		}
+	} else {
+		for (i =3D 0; i < len; i++) {
+			c =3D data[lenbe - i];
+			for (ibit =3D 0; ibit < 8; ibit++) {
+				crc <<=3D 1;
+				if ((c ^ crc) & 0x80)
+					crc ^=3D 0x09;
+
+				c <<=3D 1;
+			}
+
+			crc &=3D 0x7F;
+		}
+	}
+
+	return crc;
+}
+
+static inline void lowspeed_mkcommand(u8 cmdindx, u32 arg, u8 *retcmd)
+{
+	retcmd[0] =3D BIT(6) | cmdindx;
+	retcmd[1] =3D arg >> 24;
+	retcmd[2] =3D arg >> 16;
+	retcmd[3] =3D arg >> 8;
+	retcmd[4] =3D arg;
+	retcmd[5] =3D
+		(0x1 | (ts7800v1_sdmmc_crc7(0, retcmd, 0x5, LE_ENDIAN) << 1));
+}
+
+/*
+ * return 0 : 8 bit TS-SDCORE v1
+ * return 1 : 8 bit 4x8 TS-SDCORE v2
+ * return 2 : 32 bit 4x32 TS-SDCORE v2 (TS-7800v1 hw_version 0x2)
+ * return 3 : 16 bit 4x32 TS-SDCORE v2
+ * return 4 : 8 bit 4x32 TS-SDCORE v2
+ */
+static int ts7800v1_sdmmc_hw_version(struct ts7800v1_sdmmc_host *ts_sdmm=
c_host)
+{
+	u8 a, b;
+	u32 c;
+	u16 d;
+	int ret;
+
+	/*
+	 * Bit-30 On TS-SDCORE 2, this bit is stuck 0. On TS-SDCORE 1, this bit=
 is read/write.
+	 * This can be used for detecting which hardware core is present.
+	 */
+	a =3D readb(ts_sdmmc_host->base_iomem + 0x3);
+
+	writeb((a | BIT(6)), ts_sdmmc_host->base_iomem + 0x3);
+
+	b =3D readb(ts_sdmmc_host->base_iomem + 0x3);
+
+	/* restore */
+	writeb(a, ts_sdmmc_host->base_iomem + 0x3);
+
+	if ((a & BIT(6)) ^ (b & BIT(6))) {
+		ret =3D 0;
+		goto print_out;
+	} else if (a & BIT(6)) {
+		ret =3D 1;
+		goto print_out;
+	}
+
+	c =3D readl(ts_sdmmc_host->base_iomem + SDCORE2_SDBUS_REG);
+	d =3D readw(ts_sdmmc_host->base_iomem + SDCORE2_SDBUS_REG);
+
+	if ((c & BIT(6)) && (d & BIT(6))) {
+		ret =3D 2;
+		goto print_out;
+	}
+
+	a =3D readb(ts_sdmmc_host->base_iomem + SDCORE2_SDBUS_REG);
+	if (a & BIT(6)) {
+		ret =3D 3;
+		goto print_out;
+	} else {
+		ret =3D 4;
+		goto print_out;
+	}
+
+print_out:
+	dev_info(mmc_dev(ts_sdmmc_host->mmc_host), "Detected SDCoreV%d\n", ret)=
;
+	return ret;
+}
+
+static inline u8 get_clksel(struct ts7800v1_sdmmc_host *ts_sdmmc_host)
+{
+	return readb(ts_sdmmc_host->base_iomem + 0x2) & GENMASK(2, 0);
+}
+
+static inline void set_clksel(struct ts7800v1_sdmmc_host *ts_sdmmc_host,
+			      u8 slot)
+{
+	u8 a;
+
+	spin_lock_bh(&ts_sdmmc_host->bh_lock);
+	a =3D get_clksel(ts_sdmmc_host);
+	a &=3D ~(GENMASK(2, 0));
+	a |=3D (slot & GENMASK(2, 0));
+	writeb(a, ts_sdmmc_host->base_iomem + 0x2);
+	spin_unlock_bh(&ts_sdmmc_host->bh_lock);
+}
+
+static u32 set_clkspd(struct ts7800v1_sdmmc_host *ts_sdmmc_host,
+		      struct ts7800v1_sdmmc_slot *pslot, bool high_speed)
+{
+	u8 a;
+
+	/* since this is a single host multi slot/card state machine */
+	/* always change clock frequency for current slot */
+	spin_lock_bh(&ts_sdmmc_host->bh_lock);
+	pslot->sd_state &=3D ~(SD_LOWSPEED);
+	a =3D readb(ts_sdmmc_host->base_iomem + 0x1);
+	a &=3D ~(BIT(5));
+	if (high_speed) {
+		a |=3D BIT(5);
+		writeb(a, ts_sdmmc_host->base_iomem + 0x1);
+	} else {
+		writeb(a, ts_sdmmc_host->base_iomem + 0x1);
+		pslot->sd_state |=3D SD_LOWSPEED;
+	}
+	spin_unlock_bh(&ts_sdmmc_host->bh_lock);
+
+	return (pslot->sd_state & SD_LOWSPEED);
+}
+
+static u32 set_mlt_rdwr(struct ts7800v1_sdmmc_host *ts_sdmmc_host,
+			struct ts7800v1_sdmmc_slot *pslot, bool multi_word)
+{
+	u8 a;
+
+	/* since this is a single host multi slot/card state machine */
+	/* always change read/write type for current slot */
+	spin_lock_bh(&ts_sdmmc_host->bh_lock);
+	pslot->sd_state &=3D ~SD_MULTI_BLK;
+	a =3D readb(ts_sdmmc_host->base_iomem + 0x1);
+	a &=3D ~(GENMASK(4, 3));
+	if (multi_word) {
+		a |=3D GENMASK(4, 3);
+		writeb(a, ts_sdmmc_host->base_iomem + 0x1);
+		pslot->sd_state |=3D SD_MULTI_BLK;
+	} else {
+		writeb(a, ts_sdmmc_host->base_iomem + 0x1);
+	}
+	spin_unlock_bh(&ts_sdmmc_host->bh_lock);
+
+	return (a & GENMASK(4, 3));
+}
+
+static int activate_slot_clk(struct ts7800v1_sdmmc_host *ts_sdmmc_host, =
u8 slot)
+{
+	struct ts7800v1_sdmmc_slot *pslot =3D &ts_sdmmc_host->sd_slot[slot];
+	bool high_speed, multi_rw;
+
+	/* Are we already selected? */
+	if ((pslot->sd_state & (SD_SELECTED | SD_RESET)) =3D=3D SD_SELECTED)
+		return 0;
+
+	/* Change clock routing */
+	set_clksel(ts_sdmmc_host, slot);
+
+	/* Change clock freq/multi-blk read/write */
+	multi_rw =3D (pslot->sd_state & SD_MULTI_BLK) ? true : false;
+	set_mlt_rdwr(ts_sdmmc_host, pslot, multi_rw);
+	high_speed =3D (pslot->sd_state & SD_LOWSPEED) ? false : true;
+	set_clkspd(ts_sdmmc_host, pslot, high_speed);
+
+	/* mark us as selected */
+	pslot->sd_state |=3D SD_SELECTED;
+
+	return 0;
+}
+
+static int card_reset(struct ts7800v1_sdmmc_host *ts_sdmmc_host, u8 slot=
)
+{
+	struct ts7800v1_sdmmc_slot *pslot =3D &ts_sdmmc_host->sd_slot[slot];
+	u16 i;
+	u8 a;
+
+	/* reset sdmmc state bits */
+	pslot->sd_state =3D 0x0;
+
+	/* start with low speed */
+	pslot->sd_state |=3D SD_LOWSPEED;
+
+	/* select which LUN gets the clocks */
+	activate_slot_clk(ts_sdmmc_host, slot);
+
+	/* disable clk, cmd and dat[0-3] =3D> power off SD card */
+	writeb(0x0, ts_sdmmc_host->base_iomem);
+	msleep(100);
+
+	writeb(CMDENB_DATTRI_SDCLKH_SDCMDH_SDDATH, ts_sdmmc_host->base_iomem);
+	usleep_range(200, 300);
+	writeb(CMDENB_DATTRI_SDCLKL_SDCMDL_SDDATH, ts_sdmmc_host->base_iomem);
+	msleep(100);
+
+	// generate free 750-clocks cycles for the cards
+	for (i =3D 0; i < 750; ++i) {
+		writeb(CMDTRI_DATTRI_SDCLKH_SDCMDH_SDDATH,
+		       ts_sdmmc_host->base_iomem);
+
+		/* 2-delay reads */
+		add_2readb_delay(ts_sdmmc_host);
+
+		/* toggle low slow clk-line */
+		writeb(CMDTRI_DATTRI_SDCLKL_SDCMDH_SDDATH,
+		       ts_sdmmc_host->base_iomem);
+
+		/* 2-delay reads */
+		add_2readb_delay(ts_sdmmc_host);
+	}
+
+	/* reset any timeout/crc conditions */
+	a =3D readb(ts_sdmmc_host->base_iomem + 0x1);
+
+	/* set card-detect and write-protect */
+	pslot->sd_detect =3D (a & BIT(0)) ? true : false;
+	pslot->sd_wprot =3D (a & BIT(1)) ? true : false;
+
+	pslot->sd_state &=3D ~(SD_RESET);
+
+	return 0;
+}
+
+/* set/clear bit location in any contiguous memory buffer/fifo
+ * this function assumes pfifo content are cleared prior to calling it
+ */
+static inline void set_fifo_bit(u8 *pfifo, uint32_t cycle, u8 value)
+{
+	u32 byte_indx =3D cycle >> 3;
+	u8 bit_indx =3D cycle - (byte_indx << 3);
+
+	if (value)
+		pfifo[byte_indx] |=3D BIT(bit_indx);
+	else
+		pfifo[byte_indx] &=3D ~BIT(bit_indx);
+}
+
+/* reversed big endian set/clear bit location in any contiguous memory b=
uffer/fifo
+ * this function assumes pfifo content are cleared prior to calling it
+ */
+static inline void set_fifo_bit_reversed(u8 *pfifo, uint32_t cycle, u8 v=
alue)
+{
+	u32 byte_indx =3D cycle >> 3;
+	u8 bit_indx =3D 7 - (cycle - (byte_indx << 3));
+
+	if (value)
+		pfifo[byte_indx] |=3D BIT(bit_indx);
+	else
+		pfifo[byte_indx] &=3D ~BIT(bit_indx);
+}
+
+static inline void set_fifo_nibble_reversed(u8 *pfifo, uint32_t nibble_c=
ycle,
+					    u8 value)
+{
+	u32 byte_indx =3D nibble_cycle >> 1;
+	u8 nibble_indx =3D (nibble_cycle - (byte_indx << 1));
+
+	if (nibble_indx)
+		pfifo[byte_indx] |=3D (value & GENMASK(3, 0));
+	else
+		pfifo[byte_indx] |=3D ((value & GENMASK(3, 0)) << 0x4);
+}
+
+/* bitbang read SD_CMD/SD_DAT (high speed) */
+static inline void
+read_sd_cmd_sd_dat_highspeed(struct ts7800v1_sdmmc_host *ts_sdmmc_host,
+			     u8 *sdcmd_buffer, u8 *sddat_buffer,
+			     u32 sdcmd_cycles, u32 sddat_nibble_cycles, u8 slot)
+{
+	struct ts7800v1_sdmmc_slot *pslot =3D &ts_sdmmc_host->sd_slot[slot];
+	bool dat_started =3D false;
+	u32 i, sdcmd_msb_indx =3D sdcmd_cycles - 1;
+	u8 x;
+
+	/* set cmd start bit */
+	if (sdcmd_buffer !=3D NULL)
+		set_fifo_bit(sdcmd_buffer, sdcmd_msb_indx, 0x0);
+
+	/* read/sample sdcmd/sddat0 bits */
+	for (i =3D 1; i < sdcmd_cycles; i++) {
+		/* toggle high slow clk-line */
+		writeb(CMDTRI_DATTRI_SDCLKH_SDCMDH_SDDATH,
+		       ts_sdmmc_host->base_iomem);
+
+		add_1readb_delay(ts_sdmmc_host);
+
+		/* read/sample */
+		x =3D readb(ts_sdmmc_host->base_iomem);
+
+		/* toggle low slow clk-line */
+		writeb(CMDTRI_DATTRI_SDCLKL_SDCMDH_SDDATH,
+		       ts_sdmmc_host->base_iomem);
+
+		/* set cmd bit */
+		if (sdcmd_buffer !=3D NULL) {
+			set_fifo_bit(sdcmd_buffer, sdcmd_msb_indx - i,
+				     ((x & BIT(0x4)) >> 0x4));
+		}
+
+		/* set dat0-dat3 bits */
+		if (sddat_buffer !=3D NULL) {
+			if (dat_started) {
+				if (pslot->blk_buf_nibble_indx <
+				    sddat_nibble_cycles) {
+					set_fifo_nibble_reversed(
+						sddat_buffer,
+						pslot->blk_buf_nibble_indx,
+						(x & GENMASK(3, 0)));
+					pslot->blk_buf_nibble_indx++;
+				}
+
+			} else {
+				/* ignore start bit */
+				if ((x & GENMASK(3, 0)) =3D=3D 0x0)
+					dat_started =3D true;
+			}
+		}
+	}
+
+	/* continue reading remaining dat0-dat3 until next block boundary */
+	if (sddat_buffer !=3D NULL && dat_started) {
+		while (pslot->blk_buf_nibble_indx < sddat_nibble_cycles &&
+		       pslot->blk_buf_nibble_indx < MAX_BLK_SIZE_NIBBLES) {
+			/* toggle high slow clk-line */
+			writeb(CMDTRI_DATTRI_SDCLKH_SDCMDH_SDDATH,
+			       ts_sdmmc_host->base_iomem);
+
+			add_1readb_delay(ts_sdmmc_host);
+
+			/* read/sample */
+			x =3D readb(ts_sdmmc_host->base_iomem);
+
+			/* toggle low slow clk-line */
+			writeb(CMDTRI_DATTRI_SDCLKL_SDCMDH_SDDATH,
+			       ts_sdmmc_host->base_iomem);
+
+			set_fifo_nibble_reversed(sddat_buffer,
+						 pslot->blk_buf_nibble_indx,
+						 (x & GENMASK(3, 0)));
+			pslot->blk_buf_nibble_indx++;
+		}
+	}
+
+	if (pslot->blk_buf_nibble_indx =3D=3D MAX_BLK_SIZE_NIBBLES) {
+		/* read/consume sd_dat CRC16 */
+		for (i =3D 0; i < 0x20; i++) {
+			/* toggle high slow clk-line */
+			writeb(CMDTRI_DATTRI_SDCLKH_SDCMDH_SDDATH,
+			       ts_sdmmc_host->base_iomem);
+
+			add_1readb_delay(ts_sdmmc_host);
+
+			/* read/sample */
+			x =3D readb(ts_sdmmc_host->base_iomem);
+
+			/* toggle low slow clk-line */
+			writeb(CMDTRI_DATTRI_SDCLKL_SDCMDH_SDDATH,
+			       ts_sdmmc_host->base_iomem);
+
+			add_1readb_delay(ts_sdmmc_host);
+		}
+	}
+}
+
+/* bitbang read SD_CMD/SD_DAT (low speed) */
+static inline void
+read_sdcmd_sddat0_lowspeed(struct ts7800v1_sdmmc_host *ts_sdmmc_host,
+			   u8 *sdcmd_buffer, u8 *sddat0_buffer,
+			   u32 sdcmd_cycles, u32 sddat0_cycles, u8 slot)
+{
+	struct ts7800v1_sdmmc_slot *pslot =3D &ts_sdmmc_host->sd_slot[slot];
+	bool dat0_started =3D false;
+	u32 i, sdcmd_msb_indx =3D sdcmd_cycles - 1;
+	u8 x;
+
+	/* set cmd start bit */
+	if (sdcmd_buffer !=3D NULL)
+		set_fifo_bit(sdcmd_buffer, sdcmd_msb_indx, 0x0);
+
+	/* read/sample sdcmd/sddat0 bits */
+	for (i =3D 1; i < sdcmd_cycles; i++) {
+		/* toggle high slow clk-line */
+		writeb(CMDTRI_DATTRI_SDCLKH_SDCMDH_SDDATH,
+		       ts_sdmmc_host->base_iomem);
+
+		/* 2-delay read */
+		add_2readb_delay(ts_sdmmc_host);
+
+		/* read/sample */
+		x =3D readb(ts_sdmmc_host->base_iomem);
+
+		/* toggle low slow clk-line */
+		writeb(CMDTRI_DATTRI_SDCLKL_SDCMDH_SDDATH,
+		       ts_sdmmc_host->base_iomem);
+
+		/* set cmd bit */
+		if (sdcmd_buffer !=3D NULL) {
+			set_fifo_bit(sdcmd_buffer, sdcmd_msb_indx - i,
+				     ((x & BIT(0x4)) >> 0x4));
+		}
+
+		/* set dat0 bit */
+		if (sddat0_buffer !=3D NULL) {
+			if (dat0_started) {
+				if (pslot->blk_buf_cycle_indx < sddat0_cycles) {
+					set_fifo_bit_reversed(
+						sddat0_buffer,
+						pslot->blk_buf_cycle_indx,
+						(x & BIT(0x0)));
+					pslot->blk_buf_cycle_indx++;
+				}
+
+			} else {
+				/* ignore start bit */
+				if ((x & GENMASK(3, 0)) =3D=3D 0xe)
+					dat0_started =3D true;
+			}
+		}
+
+		/* 1-delay read */
+		add_1readb_delay(ts_sdmmc_host);
+	}
+}
+
+/* read/continue previously started bit read operation */
+static inline void
+read_continue_sddat0_lowspeed(struct ts7800v1_sdmmc_host *ts_sdmmc_host,
+			      u8 *sddat0_buffer, u32 start_cycle,
+			      u32 sddat0_cycles, u8 slot, bool reverse)
+{
+	u32 i, sddat0_msb_indx =3D sddat0_cycles - 1;
+
+	/* reverse bit/byte order rw DMA buffer */
+	if (reverse) {
+		/* read/sample sdcmd/sddat0 bits */
+		for (i =3D start_cycle; i < sddat0_cycles; i++) {
+			u8 x;
+			/* toggle high slow clk-line */
+			writeb(CMDTRI_DATTRI_SDCLKH_SDCMDH_SDDATH,
+			       ts_sdmmc_host->base_iomem);
+
+			/* 1-delay read */
+			add_1readb_delay(ts_sdmmc_host);
+
+			/* read/sample */
+			x =3D readb(ts_sdmmc_host->base_iomem);
+
+			/* toggle low slow clk-line */
+			writeb(CMDTRI_DATTRI_SDCLKL_SDCMDH_SDDATH,
+			       ts_sdmmc_host->base_iomem);
+
+			/* set dat0 bit */
+			if (sddat0_buffer !=3D NULL) {
+				set_fifo_bit_reversed(sddat0_buffer, i,
+						      (x & BIT(0x0)));
+			}
+
+			/* 1-delay read */
+			add_1readb_delay(ts_sdmmc_host);
+		}
+	} else {
+		/* read/sample sdcmd/sddat0 bits */
+		for (i =3D start_cycle; i < sddat0_cycles; i++) {
+			u8 x;
+			/* toggle high slow clk-line */
+			writeb(CMDTRI_DATTRI_SDCLKH_SDCMDH_SDDATH,
+			       ts_sdmmc_host->base_iomem);
+
+			/* 1-delay read */
+			add_2readb_delay(ts_sdmmc_host);
+
+			/* read/sample */
+			x =3D readb(ts_sdmmc_host->base_iomem);
+
+			/* toggle low slow clk-line */
+			writeb(CMDTRI_DATTRI_SDCLKL_SDCMDH_SDDATH,
+			       ts_sdmmc_host->base_iomem);
+
+			/* set dat0 bit */
+			if (sddat0_buffer !=3D NULL) {
+				set_fifo_bit(sddat0_buffer, sddat0_msb_indx - i,
+					     (x & BIT(0x0)));
+			}
+
+			/* 1-delay read */
+			add_1readb_delay(ts_sdmmc_host);
+		}
+	}
+}
+
+static inline void sd_cmd_write(struct ts7800v1_sdmmc_host *ts_sdmmc_hos=
t,
+				u8 offset, u32 opcode, u32 arg)
+{
+	writeb(CMDENB_DATTRI_SDCLKH_SDCMDH_SDDATH, ts_sdmmc_host->base_iomem);
+
+	if (offset =3D=3D 0x20) {
+		u32 x =3D 0x0;
+
+		x =3D ((BIT(6) | opcode) & 0xff) << 24;
+		x |=3D ((arg >> 24) & 0xff) << 16;
+		x |=3D ((arg >> 16) & 0xff) << 8;
+		x |=3D ((arg >> 8) & 0xff);
+
+		writel(x, ts_sdmmc_host->base_iomem + SDCORE2_SDCMD_REG);
+
+		/* send remaining 1-byte of arg */
+		/* NOTE: CRC7 + STOP bit are added automatically */
+		x =3D (arg & 0xff) << 24;
+		writel(x, ts_sdmmc_host->base_iomem + SDCORE2_SDCMD_REG);
+
+	} else if (offset =3D=3D 0x10) {
+		u16 x =3D 0x0;
+
+		x =3D (opcode & 0xff) << 8;
+		x |=3D ((arg >> 24) & 0xff);
+		writew(x, ts_sdmmc_host->base_iomem + SDCORE2_SDCMD_REG);
+
+		x =3D ((arg >> 16) & 0xff) << 8;
+		x |=3D ((arg >> 8) & 0xff);
+		writew(x, ts_sdmmc_host->base_iomem + SDCORE2_SDCMD_REG);
+
+		x =3D (arg & 0xff) << 8;
+		writew(x, ts_sdmmc_host->base_iomem + SDCORE2_SDCMD_REG);
+	} else {
+		u8 x =3D 0x0;
+
+		x =3D (opcode & 0xff);
+		writeb(x, ts_sdmmc_host->base_iomem + SDCORE2_SDCMD_REG);
+		x =3D ((arg >> 24) & 0xff);
+		writeb(x, ts_sdmmc_host->base_iomem + SDCORE2_SDCMD_REG);
+		x =3D ((arg >> 16) & 0xff);
+		writeb(x, ts_sdmmc_host->base_iomem + SDCORE2_SDCMD_REG);
+		x =3D ((arg >> 8) & 0xff);
+		writeb(x, ts_sdmmc_host->base_iomem + SDCORE2_SDCMD_REG);
+		x =3D ((arg)&0xff);
+		writeb(x, ts_sdmmc_host->base_iomem + SDCORE2_SDCMD_REG);
+	}
+
+	writeb(CMDTRI_DATTRI_SDCLKL_SDCMDH_SDDATH, ts_sdmmc_host->base_iomem);
+}
+
+static inline void sd_cmd_read(struct ts7800v1_sdmmc_host *ts_sdmmc_host=
,
+			       struct ts7800v1_sdmmc_slot *pslot,
+			       u8 resp_len_bytes, size_t sz)
+{
+	u8 i, j;
+	u8 x8, resp_last_byte =3D resp_len_bytes - 1;
+	u16 x16;
+	u32 x32;
+
+	for (i =3D 0; i < resp_len_bytes; i++) {
+		if (!(i % sz)) {
+			u8 shift =3D (sz - 1) << 3;
+
+			if (sz =3D=3D sizeof(x8)) {
+				x8 =3D readb(ts_sdmmc_host->base_iomem +
+					   SDCORE2_SDCMD_REG);
+				for (j =3D i; j < i + sz; ++j) {
+					if (j < resp_len_bytes) {
+						pslot->response[resp_last_byte -
+								j] =3D
+							(x8 >> shift) & 0xff;
+						shift -=3D 8;
+					}
+				}
+			} else if (sz =3D=3D sizeof(x16)) {
+				x16 =3D readw(ts_sdmmc_host->base_iomem +
+					    SDCORE2_SDCMD_REG);
+				for (j =3D i; j < i + sz; ++j) {
+					if (j < resp_len_bytes) {
+						pslot->response[resp_last_byte -
+								j] =3D
+							(x16 >> shift) & 0xff;
+						shift -=3D 8;
+					}
+				}
+			} else {
+				x32 =3D (readl(ts_sdmmc_host->base_iomem +
+					     SDCORE2_SDCMD_REG));
+
+				for (j =3D i; j < i + sz; ++j) {
+					if (j < resp_len_bytes) {
+						pslot->response[resp_last_byte -
+								j] =3D
+							(x32 >> shift) & 0xff;
+
+						shift -=3D 8;
+					}
+				}
+			}
+		}
+	}
+}
+
+/* This function should be called after holding spin lock */
+static inline void send_serialize_cmd(struct ts7800v1_sdmmc_host *ts_sdm=
mc_host,
+				      struct ts7800v1_sdmmc_slot *pslot,
+				      u32 opcode, u32 arg)
+{
+	add_2clk_cycles_high(ts_sdmmc_host);
+	sd_cmd_write(ts_sdmmc_host, 0x20, opcode, arg);
+}
+
+/* This function should be called after holding mutex lock */
+static inline void wait_for_response(struct ts7800v1_sdmmc_host *ts_sdmm=
c_host,
+				     struct ts7800v1_sdmmc_slot *pslot,
+				     bool low_speed)
+{
+	pslot->cmd_timeout =3D 0x0;
+	for (pslot->cmd_timeout =3D 0;
+	     pslot->cmd_timeout < MAX_RESP_TIMEOUT_MICROSECS;
+	     ++pslot->cmd_timeout) {
+		u8 x;
+
+		/* toggle high slow clk-line */
+		writeb(CMDTRI_DATTRI_SDCLKH_SDCMDH_SDDATH,
+		       ts_sdmmc_host->base_iomem);
+
+		/* add 1-delay */
+		if (low_speed)
+			add_1readb_delay(ts_sdmmc_host);
+
+		/* read/sample sd_cmd state */
+		x =3D readb(ts_sdmmc_host->base_iomem);
+
+		/* toggle low slow clk-line */
+		writeb(CMDTRI_DATTRI_SDCLKL_SDCMDH_SDDATH,
+		       ts_sdmmc_host->base_iomem);
+
+		/* add 2-delay */
+		if (low_speed)
+			add_2readb_delay(ts_sdmmc_host);
+
+		if ((x & 0x10) =3D=3D 0x0)
+			break;
+
+		usleep_range(1, 2);
+	}
+}
+
+static inline void
+send_sddat_start_nibble(struct ts7800v1_sdmmc_host *ts_sdmmc_host)
+{
+	add_2clk_cycles_high(ts_sdmmc_host);
+
+	/* write start bit */
+	writeb(CMDENB_DATENB_SDCLKH_SDCMDH_SDDAT03L, ts_sdmmc_host->base_iomem)=
;
+	/* 1-delay reads */
+	add_1readb_delay(ts_sdmmc_host);
+
+	writeb(CMDENB_DATENB_SDCLKL_SDCMDH_SDDAT03L, ts_sdmmc_host->base_iomem)=
;
+	/* 1-delay reads */
+	add_1readb_delay(ts_sdmmc_host);
+}
+
+static int send_cmd_recv_resp_simple(struct ts7800v1_sdmmc_host *ts_sdmm=
c_host,
+				     u8 slot, u32 cmd_opcode, u32 cmd_arg,
+				     unsigned int cmd_flags, int *cmd_error,
+				     u32 *cmd_resp)
+{
+	struct ts7800v1_sdmmc_slot *pslot =3D &ts_sdmmc_host->sd_slot[slot];
+	u8 stat, resp_len_bytes, sent_resp_crc7, calc_resp_crc7;
+	bool low_speed;
+	int ret =3D 0x0, i;
+
+	/* initial ok state, following are not pre-set by default */
+	pslot->sg_count =3D -1;
+	pslot->cmd_timeout =3D 0x0;
+	pslot->blk_buf_cycle_indx =3D pslot->blk_buf_nibble_indx =3D 0x0;
+
+	/* low speed =3D sample on cmd-line, dat0-line */
+	low_speed =3D (pslot->sd_state & SD_LOWSPEED) ? true : false;
+
+	activate_slot_clk(ts_sdmmc_host, slot);
+
+	/* serialize command */
+	spin_lock_bh(&ts_sdmmc_host->bh_lock);
+	send_serialize_cmd(ts_sdmmc_host, pslot, cmd_opcode, cmd_arg);
+	spin_unlock_bh(&ts_sdmmc_host->bh_lock);
+
+	switch ((cmd_flags & (MMC_RSP_PRESENT | MMC_RSP_136 | MMC_RSP_CRC |
+			      MMC_RSP_BUSY | MMC_RSP_OPCODE))) {
+	case MMC_RSP_NONE:
+		resp_len_bytes =3D 0x0;
+		goto done;
+	case MMC_RSP_R1:
+	case MMC_RSP_R1B:
+	case MMC_RSP_R3:
+		resp_len_bytes =3D NORM_RESP_BYTES;
+		break;
+	case MMC_RSP_R2:
+		resp_len_bytes =3D LONG_RESP_BYTES;
+		break;
+	default:
+		dev_warn(mmc_dev(ts_sdmmc_host->mmc_host),
+			 "%s|%d - Warning, Invalid response type\n", __func__,
+			 __LINE__);
+		*cmd_error =3D ret =3D -EINVAL;
+		goto done;
+	}
+
+	if (cmd_flags & MMC_RSP_PRESENT) {
+		/* wait for response, i.e. start bit=3D0 on slow sd_cmd */
+		mutex_lock(&ts_sdmmc_host->mutex_lock);
+		wait_for_response(ts_sdmmc_host, pslot, low_speed);
+		mutex_unlock(&ts_sdmmc_host->mutex_lock);
+
+		if (pslot->cmd_timeout >=3D MAX_RESP_TIMEOUT_MICROSECS) {
+			*cmd_error =3D ret =3D -ETIMEDOUT;
+			goto done;
+		}
+
+		/* serialize/consume cmd response */
+		spin_lock_bh(&ts_sdmmc_host->bh_lock);
+		if (!low_speed && (pslot->sd_state & DATSSP_4BIT)) {
+			sd_cmd_read(ts_sdmmc_host, pslot, resp_len_bytes,
+				    sizeof(u32));
+
+		} else {
+			/* NOTE: response includes crc7 and stop bit */
+			read_sdcmd_sddat0_lowspeed(
+				ts_sdmmc_host, pslot->response, NULL,
+				(resp_len_bytes * BYTE_CLK_CYCLES), 0x0, slot);
+		}
+
+		spin_unlock_bh(&ts_sdmmc_host->bh_lock);
+
+		/* process data outside of spin locks */
+		if (cmd_flags & MMC_RSP_136) {
+			/* R2, copy 12-bytes/3-double-words of argument including internal CR=
C7 */
+			memcpy(&cmd_resp[0], &pslot->response[12], 0x4);
+			memcpy(&cmd_resp[1], &pslot->response[8], 0x4);
+			memcpy(&cmd_resp[2], &pslot->response[4], 0x4);
+			memcpy(&cmd_resp[3], &pslot->response[0], 0x4);
+		} else {
+			/* R1, R1b, R3, R4, R5, R6 4-bytes arguments only*/
+			memcpy(cmd_resp, &pslot->response[1], 0x4);
+		}
+
+		/* resp crc7 check */
+		switch ((cmd_flags &
+			 (MMC_RSP_PRESENT | MMC_RSP_136 | MMC_RSP_CRC |
+			  MMC_RSP_BUSY | MMC_RSP_OPCODE))) {
+		case MMC_RSP_R1:
+		case MMC_RSP_R1B:
+			sent_resp_crc7 =3D pslot->response[0] >> 1;
+			calc_resp_crc7 =3D
+				ts7800v1_sdmmc_crc7(0, &pslot->response[1],
+						    resp_len_bytes - 1,
+						    BE_ENDIAN);
+
+			if (sent_resp_crc7 !=3D calc_resp_crc7) {
+				*cmd_error =3D ret =3D -EILSEQ;
+				goto done;
+			}
+			break;
+		default:
+			/* no crc7 check*/
+			break;
+		}
+	}
+
+	/* serialize/consume card's busy response if any */
+	if (cmd_flags & MMC_RSP_BUSY) {
+		stat =3D 0x0;
+		/* reset cmd time-out */
+		pslot->cmd_timeout =3D 0x0;
+
+		mutex_lock(&ts_sdmmc_host->mutex_lock);
+
+		while ((stat & 0x7) !=3D 0x7) {
+			if (pslot->cmd_timeout++ >=3D
+			    MAX_BUSY_TIMEOUT_MICROSECS) {
+				*cmd_error =3D ret =3D -ETIMEDOUT;
+				goto done;
+			}
+
+			/* toggle high slow clk-line */
+			writeb(CMDTRI_DATTRI_SDCLKH_SDCMDH_SDDATH,
+			       ts_sdmmc_host->base_iomem);
+
+			/* 1-delay reads */
+			if (low_speed)
+				add_1readb_delay(ts_sdmmc_host);
+
+			stat =3D stat << 1;
+			stat |=3D readb(ts_sdmmc_host->base_iomem) & 0x1;
+
+			/* toggle low slow clk-line */
+			writeb(CMDTRI_DATTRI_SDCLKL_SDCMDH_SDDATH,
+			       ts_sdmmc_host->base_iomem);
+
+			/* 1-delay reads */
+			if (low_speed)
+				add_1readb_delay(ts_sdmmc_host);
+
+			usleep_range(15, 25);
+		}
+
+		mutex_unlock(&ts_sdmmc_host->mutex_lock);
+	}
+
+	*cmd_error =3D ret =3D 0x0;
+
+done:
+
+	// 8 clocks before stopping
+	spin_lock_bh(&ts_sdmmc_host->bh_lock);
+
+	if (low_speed)
+		for (i =3D 0; i < 8; i++) {
+			/* toggle hi slow clk-line */
+			writeb(CMDTRI_DATTRI_SDCLKH_SDCMDH_SDDATH,
+			       ts_sdmmc_host->base_iomem);
+			/* 2-delay reads */
+			add_2readb_delay(ts_sdmmc_host);
+
+			/* toggle low slow clk-line */
+			writeb(CMDTRI_DATTRI_SDCLKL_SDCMDH_SDDATH,
+			       ts_sdmmc_host->base_iomem);
+			/* 2-delay reads */
+			add_2readb_delay(ts_sdmmc_host);
+		}
+	else {
+		/* send 8-bits on fast clk-line */
+		writeb(0xff, ts_sdmmc_host->base_iomem + SDCORE2_SDCMD_REG);
+	}
+
+	spin_unlock_bh(&ts_sdmmc_host->bh_lock);
+
+	return ret;
+}
+
+static int send_cmd_recv_resp_read_blk(
+	struct ts7800v1_sdmmc_host *ts_sdmmc_host, u8 slot, u32 cmd_opcode,
+	u32 cmd_arg, unsigned int cmd_flags, int *cmd_error, u32 *cmd_resp,
+	unsigned int data_blksz, u32 data_offset, int *data_error)
+{
+	struct ts7800v1_sdmmc_slot *pslot =3D &ts_sdmmc_host->sd_slot[slot];
+	u32 blksz_dwords =3D data_blksz >> 2;
+	u16 sent_dat0_crc16, calc_crc16;
+	u8 stat, resp_len_bytes, sent_resp_crc7, calc_resp_crc7,
+		*dat0_sent_crc16_buf =3D NULL;
+	bool low_speed, data_read_done;
+	int ret =3D 0x0, i;
+
+	/* initial ok state, following are not pre-set by default */
+	pslot->sg_count =3D -1;
+	pslot->cmd_timeout =3D 0x0;
+	pslot->blk_buf_cycle_indx =3D pslot->blk_buf_nibble_indx =3D 0x0;
+	data_read_done =3D false;
+	/* clear crc_err/timeout */
+	readb(ts_sdmmc_host->base_iomem + 0x1);
+
+	/* low speed =3D sample on cmd-line, dat0-line */
+	low_speed =3D (pslot->sd_state & SD_LOWSPEED) ? true : false;
+
+	activate_slot_clk(ts_sdmmc_host, slot);
+
+	if (IS_ERR_OR_NULL(pslot->rw_dma_buf)) {
+		dev_warn(mmc_dev(ts_sdmmc_host->mmc_host),
+			 "%s|%d - Error, No allocated DMA read buffer %ld\n",
+			 __func__, __LINE__, PTR_ERR(pslot->rw_dma_buf));
+		*data_error =3D ret =3D -ENOMEM;
+		goto done;
+	}
+
+	dat0_sent_crc16_buf =3D kzalloc(sizeof(u16), GFP_KERNEL);
+	if (IS_ERR_OR_NULL(dat0_sent_crc16_buf)) {
+		dev_warn(
+			mmc_dev(ts_sdmmc_host->mmc_host),
+			"%s|%d - Error, kzalloc 'dat0_sent_crc16_buf' of size %u failed with =
%ld\n",
+			__func__, __LINE__, sizeof(u16),
+			PTR_ERR(dat0_sent_crc16_buf));
+		*data_error =3D ret =3D -ENOMEM;
+		goto done;
+	}
+
+	if (!(cmd_flags & MMC_RSP_PRESENT)) {
+		dev_warn(
+			mmc_dev(ts_sdmmc_host->mmc_host),
+			"%s|%d - Error, read block command flgas must have a response\n",
+			__func__, __LINE__);
+		*cmd_error =3D ret =3D -EINVAL;
+	} else {
+		switch ((cmd_flags &
+			 (MMC_RSP_PRESENT | MMC_RSP_136 | MMC_RSP_CRC |
+			  MMC_RSP_BUSY | MMC_RSP_OPCODE))) {
+		case MMC_RSP_NONE:
+			resp_len_bytes =3D 0x0;
+			goto done;
+		case MMC_RSP_R1:
+		case MMC_RSP_R1B:
+		case MMC_RSP_R3:
+			resp_len_bytes =3D NORM_RESP_BYTES;
+			break;
+		case MMC_RSP_R2:
+			resp_len_bytes =3D LONG_RESP_BYTES;
+			break;
+		default:
+			dev_warn(mmc_dev(ts_sdmmc_host->mmc_host),
+				 "%s|%d - Warning, Invalid response type\n",
+				 __func__, __LINE__);
+			*cmd_error =3D ret =3D -EINVAL;
+			goto done;
+		}
+	}
+
+	/* serialize command */
+	spin_lock_bh(&ts_sdmmc_host->bh_lock);
+	send_serialize_cmd(ts_sdmmc_host, pslot, cmd_opcode, cmd_arg);
+	spin_unlock_bh(&ts_sdmmc_host->bh_lock);
+
+	/* wait for response, i.e. start bit=3D0 on slow sd_cmd */
+	mutex_lock(&ts_sdmmc_host->mutex_lock);
+	wait_for_response(ts_sdmmc_host, pslot, low_speed);
+	mutex_unlock(&ts_sdmmc_host->mutex_lock);
+
+	if (pslot->cmd_timeout >=3D MAX_RESP_TIMEOUT_MICROSECS) {
+		*cmd_error =3D ret =3D -ETIMEDOUT;
+		goto done;
+	}
+
+	/* serialize/consume cmd response */
+	if (!low_speed && (pslot->sd_state & DATSSP_4BIT)) {
+		spin_lock_bh(&ts_sdmmc_host->bh_lock);
+		read_sd_cmd_sd_dat_highspeed(
+			ts_sdmmc_host, pslot->response, pslot->rw_dma_buf,
+			resp_len_bytes * BYTE_CLK_CYCLES,
+			data_blksz << DAT03_NIBBLES_PER_CLK_CYCLE, slot);
+
+		if (pslot->blk_buf_nibble_indx !=3D 0) {
+			if (pslot->blk_buf_nibble_indx < (data_blksz << 1)) {
+				u32 blk_buf_nibble_indx_dwords;
+
+				stat =3D 0x0;
+
+				/* ignore One-cycle Pull-up */
+				writeb(CMDTRI_DATTRI_SDCLKH_SDCMDH_SDDATH,
+				       ts_sdmmc_host->base_iomem);
+				/* read/sample */
+				readb(ts_sdmmc_host->base_iomem);
+				/* toggle low slow clk-line */
+				writeb(CMDTRI_DATTRI_SDCLKL_SDCMDH_SDDATH,
+				       ts_sdmmc_host->base_iomem);
+				add_1readb_delay(ts_sdmmc_host);
+
+				blk_buf_nibble_indx_dwords =3D
+					pslot->blk_buf_nibble_indx >> 3;
+				for (i =3D blk_buf_nibble_indx_dwords;
+				     i < blksz_dwords; ++i) {
+					u32 x32;
+
+					if (!(i % MAX_BLK_SIZE_DWORDS)) {
+						/* check/clear crc_err/timeout */
+						stat =3D readb(
+							ts_sdmmc_host
+								->base_iomem +
+							0x1);
+
+						if (stat & BIT(2)) {
+							spin_unlock_bh(
+								&ts_sdmmc_host
+									 ->bh_lock);
+
+							dev_warn(
+								mmc_dev(ts_sdmmc_host
+										->mmc_host),
+								"%s|%d - Warning, dat0-3 crc16 mismatch\n",
+								__func__,
+								__LINE__);
+
+							*data_error =3D ret =3D
+								-EILSEQ;
+
+							goto done;
+						}
+
+						if (stat & BIT(6)) {
+							spin_unlock_bh(
+								&ts_sdmmc_host
+									 ->bh_lock);
+
+							dev_warn(
+								mmc_dev(ts_sdmmc_host
+										->mmc_host),
+								"%s|%d - Warning, dat0-3 time-out\n",
+								__func__,
+								__LINE__);
+
+							*data_error =3D ret =3D
+								-ETIMEDOUT;
+
+							goto done;
+						}
+					}
+
+					x32 =3D readl(ts_sdmmc_host->base_iomem +
+						    SDCORE2_SDDATA_REG);
+
+					memcpy(&pslot->rw_dma_buf[i << 2], &x32,
+					       sizeof(u32));
+				}
+
+				data_read_done =3D true;
+			} else {
+				/* already completed reading data blk */
+				data_read_done =3D true;
+			}
+		}
+
+		spin_unlock_bh(&ts_sdmmc_host->bh_lock);
+
+	} else {
+		spin_lock_bh(&ts_sdmmc_host->bh_lock);
+		/* NOTE: response includes crc7 and stop bit */
+		read_sdcmd_sddat0_lowspeed(ts_sdmmc_host, pslot->response,
+					   pslot->rw_dma_buf,
+					   (resp_len_bytes * BYTE_CLK_CYCLES),
+					   (data_blksz * BYTE_CLK_CYCLES),
+					   slot);
+
+		if (pslot->blk_buf_cycle_indx !=3D 0) {
+			read_continue_sddat0_lowspeed(
+				ts_sdmmc_host, pslot->rw_dma_buf,
+				pslot->blk_buf_cycle_indx,
+				(data_blksz * BYTE_CLK_CYCLES), slot, true);
+
+			/* read dat0 CRC16 */
+			read_continue_sddat0_lowspeed(ts_sdmmc_host,
+						      dat0_sent_crc16_buf, 0x0,
+						      CRC16_CYCLES, slot,
+						      false);
+
+			sent_dat0_crc16 =3D (dat0_sent_crc16_buf[1] << 0x8) |
+					  dat0_sent_crc16_buf[0];
+
+			/* serialize/consume stop bit */
+			read_continue_sddat0_lowspeed(ts_sdmmc_host, NULL, 0x0,
+						      0x1, slot, false);
+
+			/* check data crc16 */
+			calc_crc16 =3D ts7800v1_sdmmc_crc16(pslot->rw_dma_buf,
+							  data_blksz);
+
+			if (calc_crc16 !=3D sent_dat0_crc16) {
+				spin_unlock_bh(&ts_sdmmc_host->bh_lock);
+
+				dev_warn(
+					mmc_dev(ts_sdmmc_host->mmc_host),
+					"%s|%d - Warning, dat0 crc16 mismatch sent-crc16 %#x, calc-crc16 %#=
x\n",
+					__func__, __LINE__, sent_dat0_crc16,
+					calc_crc16);
+
+				*data_error =3D ret =3D -EILSEQ;
+				goto done;
+			}
+
+			data_read_done =3D true;
+		}
+
+		spin_unlock_bh(&ts_sdmmc_host->bh_lock);
+	}
+
+	/* serialize/consume card's busy response if any */
+	if (cmd_flags & MMC_RSP_BUSY) {
+		stat =3D 0x0;
+		/* reset cmd time-out */
+		pslot->cmd_timeout =3D 0x0;
+
+		mutex_lock(&ts_sdmmc_host->mutex_lock);
+
+		while ((stat & 0x7) !=3D 0x7) {
+			if (pslot->cmd_timeout++ >=3D
+			    MAX_BUSY_TIMEOUT_MICROSECS) {
+				*cmd_error =3D ret =3D -ETIMEDOUT;
+				goto done;
+			}
+
+			/* toggle high slow clk-line */
+			writeb(CMDTRI_DATTRI_SDCLKH_SDCMDH_SDDATH,
+			       ts_sdmmc_host->base_iomem);
+
+			/* 1-delay reads */
+			if (low_speed)
+				add_1readb_delay(ts_sdmmc_host);
+
+			stat =3D stat << 1;
+			stat |=3D readb(ts_sdmmc_host->base_iomem) & 0x1;
+
+			/* toggle low slow clk-line */
+			writeb(CMDTRI_DATTRI_SDCLKL_SDCMDH_SDDATH,
+			       ts_sdmmc_host->base_iomem);
+
+			/* 1-delay reads */
+			if (low_speed)
+				add_1readb_delay(ts_sdmmc_host);
+
+			usleep_range(15, 25);
+		}
+
+		mutex_unlock(&ts_sdmmc_host->mutex_lock);
+	}
+
+	/* process response outside of spin locks */
+	if (cmd_flags & MMC_RSP_136) {
+		/* R2, copy 12-bytes/3-double-words of argument including internal CRC=
7 */
+		memcpy(&cmd_resp[0], &pslot->response[12], 0x4);
+		memcpy(&cmd_resp[1], &pslot->response[8], 0x4);
+		memcpy(&cmd_resp[2], &pslot->response[4], 0x4);
+		memcpy(&cmd_resp[3], &pslot->response[0], 0x4);
+	} else {
+		/* R1, R1b, R3, R4, R5, R6 4-bytes arguments only*/
+		memcpy(cmd_resp, &pslot->response[1], 0x4);
+	}
+
+	/* resp crc7 check */
+	switch ((cmd_flags & (MMC_RSP_PRESENT | MMC_RSP_136 | MMC_RSP_CRC |
+			      MMC_RSP_BUSY | MMC_RSP_OPCODE))) {
+	case MMC_RSP_R1:
+	case MMC_RSP_R1B:
+		sent_resp_crc7 =3D pslot->response[0] >> 1;
+		calc_resp_crc7 =3D ts7800v1_sdmmc_crc7(
+			0, &pslot->response[1], resp_len_bytes - 1, BE_ENDIAN);
+
+		if (sent_resp_crc7 !=3D calc_resp_crc7) {
+			*cmd_error =3D ret =3D -EILSEQ;
+			goto done;
+		}
+		break;
+	default:
+		/* no crc7 check*/
+		break;
+	}
+
+	if (!data_read_done) {
+		/* wait for data lines to become low, i.e. dat[0-3]=3D0x0 */
+		if (!low_speed && (pslot->sd_state & DATSSP_4BIT)) {
+			mutex_lock(&ts_sdmmc_host->mutex_lock);
+			/* wait for start block token */
+			pslot->cmd_timeout =3D 0x0;
+			stat =3D 0xff;
+
+			while ((stat & 0xf) =3D=3D 0xf) {
+				if (pslot->cmd_timeout++ >=3D
+				    MAX_BUSY_TIMEOUT_MICROSECS) {
+					/* reset time-out before going to done,
+					 * since cmd may have been successful and
+					 * only data-transfer failed
+					 */
+					pslot->cmd_timeout =3D 0x0;
+					*data_error =3D ret =3D -ETIMEDOUT;
+
+					mutex_unlock(
+						&ts_sdmmc_host->mutex_lock);
+					goto done;
+				}
+
+				/* toggle high slow clk-line */
+				writeb(CMDTRI_DATTRI_SDCLKH_SDCMDH_SDDATH,
+				       ts_sdmmc_host->base_iomem);
+
+				/* 1-delay reads */
+				add_1readb_delay(ts_sdmmc_host);
+
+				/* toggle low slow clk-line */
+				writeb(CMDTRI_DATTRI_SDCLKL_SDCMDH_SDDATH,
+				       ts_sdmmc_host->base_iomem);
+
+				stat =3D readb(ts_sdmmc_host->base_iomem);
+
+				usleep_range(15, 25);
+			}
+
+			mutex_unlock(&ts_sdmmc_host->mutex_lock);
+
+			spin_lock_bh(&ts_sdmmc_host->bh_lock);
+
+			/* ignore One-cycle Pull-up */
+			for (i =3D 0; i < 0x1; ++i) {
+				/* toggle high slow clk-line */
+				writeb(CMDTRI_DATTRI_SDCLKH_SDCMDH_SDDATH,
+				       ts_sdmmc_host->base_iomem);
+
+				add_1readb_delay(ts_sdmmc_host);
+
+				/* read/sample */
+				stat =3D (readb(ts_sdmmc_host->base_iomem) & 0xf);
+
+				/* toggle low slow clk-line */
+				writeb(CMDTRI_DATTRI_SDCLKL_SDCMDH_SDDATH,
+				       ts_sdmmc_host->base_iomem);
+
+				/* add 2-clk delay */
+				add_2readb_delay(ts_sdmmc_host);
+			}
+
+			for (i =3D 0; i < blksz_dwords; i++) {
+				u32 x32;
+
+				if (!(i % MAX_BLK_SIZE_DWORDS)) {
+					/* check/clear crc_err/timeout */
+					stat =3D readb(ts_sdmmc_host->base_iomem +
+						     0x1);
+
+					if (stat & BIT(2)) {
+						spin_unlock_bh(
+							&ts_sdmmc_host->bh_lock);
+
+						dev_warn(
+							mmc_dev(ts_sdmmc_host
+									->mmc_host),
+							"%s|%d - Warning, dat0-3 crc16 mismatch\n",
+							__func__, __LINE__);
+
+						*data_error =3D ret =3D -EILSEQ;
+
+						goto done;
+					}
+
+					if (stat & BIT(6)) {
+						spin_unlock_bh(
+							&ts_sdmmc_host->bh_lock);
+
+						dev_warn(
+							mmc_dev(ts_sdmmc_host
+									->mmc_host),
+							"%s|%d - Warning, dat0-3 time-out\n",
+							__func__, __LINE__);
+
+						*data_error =3D ret =3D -ETIMEDOUT;
+
+						goto done;
+					}
+				}
+
+				x32 =3D readl(ts_sdmmc_host->base_iomem +
+					    SDCORE2_SDDATA_REG);
+
+				memcpy(&pslot->rw_dma_buf[i << 2], &x32,
+				       sizeof(u32));
+			}
+
+			spin_unlock_bh(&ts_sdmmc_host->bh_lock);
+
+		} else {
+			pslot->cmd_timeout =3D 0x0;
+			stat =3D 0xff;
+
+			mutex_lock(&ts_sdmmc_host->mutex_lock);
+			while ((stat & 0xf) =3D=3D 0xf) {
+				if (pslot->cmd_timeout++ >=3D
+				    MAX_BUSY_TIMEOUT_MICROSECS) {
+					/* reset time-out before going to done,
+					 * since cmd may have been successful and only
+					 * data-transfer failed
+					 */
+					pslot->cmd_timeout =3D 0x0;
+					*data_error =3D ret =3D -ETIMEDOUT;
+
+					mutex_unlock(
+						&ts_sdmmc_host->mutex_lock);
+					goto done;
+				}
+
+				/* toggle high slow clk-line */
+				writeb(CMDTRI_DATTRI_SDCLKH_SDCMDH_SDDATH,
+				       ts_sdmmc_host->base_iomem);
+
+				/* 2-delay reads */
+				add_2readb_delay(ts_sdmmc_host);
+
+				/* toggle low slow clk-line */
+				writeb(CMDTRI_DATTRI_SDCLKL_SDCMDH_SDDATH,
+				       ts_sdmmc_host->base_iomem);
+
+				add_1readb_delay(ts_sdmmc_host);
+
+				stat =3D readb(ts_sdmmc_host->base_iomem);
+
+				usleep_range(15, 25);
+			}
+
+			mutex_unlock(&ts_sdmmc_host->mutex_lock);
+
+			spin_lock_bh(&ts_sdmmc_host->bh_lock);
+			/* ignore start bit */
+			for (i =3D 0; i < 0x1; ++i) {
+				/* toggle high slow clk-line */
+				writeb(CMDTRI_DATTRI_SDCLKH_SDCMDH_SDDATH,
+				       ts_sdmmc_host->base_iomem);
+
+				add_1readb_delay(ts_sdmmc_host);
+
+				/* read/sample */
+				stat =3D (readb(ts_sdmmc_host->base_iomem) & 0xf);
+
+				/* toggle low slow clk-line */
+				writeb(CMDTRI_DATTRI_SDCLKL_SDCMDH_SDDATH,
+				       ts_sdmmc_host->base_iomem);
+
+				/* add 2-clk delay */
+				add_2readb_delay(ts_sdmmc_host);
+			}
+
+			/* consume data, read dat0 */
+			read_continue_sddat0_lowspeed(
+				ts_sdmmc_host, pslot->rw_dma_buf, 0x0,
+				data_blksz * BYTE_CLK_CYCLES, slot, true);
+
+			/* read dat0 CRC16 */
+			read_continue_sddat0_lowspeed(ts_sdmmc_host,
+						      dat0_sent_crc16_buf, 0x0,
+						      CRC16_CYCLES, slot,
+						      false);
+
+			sent_dat0_crc16 =3D (dat0_sent_crc16_buf[1] << 0x8) |
+					  dat0_sent_crc16_buf[0];
+
+			/* serialize/consume stop bit */
+			read_continue_sddat0_lowspeed(ts_sdmmc_host, NULL, 0x0,
+						      0x1, slot, false);
+
+			spin_unlock_bh(&ts_sdmmc_host->bh_lock);
+
+			/* check data crc16 */
+			calc_crc16 =3D ts7800v1_sdmmc_crc16(pslot->rw_dma_buf,
+							  data_blksz);
+
+			if (calc_crc16 !=3D sent_dat0_crc16) {
+				dev_warn(
+					mmc_dev(ts_sdmmc_host->mmc_host),
+					"%s|%d - Warning, dat0 crc16 mismatch sent-crc16 %#x, calc-crc16 %#=
x\n",
+					__func__, __LINE__, sent_dat0_crc16,
+					calc_crc16);
+
+				*data_error =3D ret =3D -EILSEQ;
+				goto done;
+			}
+		}
+	}
+
+	*cmd_error =3D *data_error =3D ret =3D 0x0;
+
+done:
+
+	// 8 clocks before stopping
+	spin_lock_bh(&ts_sdmmc_host->bh_lock);
+
+	if (low_speed)
+		for (i =3D 0; i < 8; i++) {
+			/* toggle hi slow clk-line */
+			writeb(CMDTRI_DATTRI_SDCLKH_SDCMDH_SDDATH,
+			       ts_sdmmc_host->base_iomem);
+			/* 2-delay reads */
+			add_2readb_delay(ts_sdmmc_host);
+
+			/* toggle low slow clk-line */
+			writeb(CMDTRI_DATTRI_SDCLKL_SDCMDH_SDDATH,
+			       ts_sdmmc_host->base_iomem);
+			/* 2-delay reads */
+			add_2readb_delay(ts_sdmmc_host);
+		}
+	else {
+		/* send 8-bits on fast clk-line */
+		writeb(0xff, ts_sdmmc_host->base_iomem + SDCORE2_SDCMD_REG);
+	}
+
+	spin_unlock_bh(&ts_sdmmc_host->bh_lock);
+
+	if (!IS_ERR_OR_NULL(dat0_sent_crc16_buf)) {
+		kfree(dat0_sent_crc16_buf);
+		dat0_sent_crc16_buf =3D NULL;
+	}
+
+	return ret;
+}
+
+static int send_cmd_recv_resp_write_blk(
+	struct ts7800v1_sdmmc_host *ts_sdmmc_host, u8 slot, u32 cmd_opcode,
+	u32 cmd_arg, unsigned int cmd_flags, int *cmd_error, u32 *cmd_resp,
+	unsigned int data_blksz, u32 data_offset, int *data_error)
+{
+	struct ts7800v1_sdmmc_slot *pslot =3D &ts_sdmmc_host->sd_slot[slot];
+	u8 stat, resp_len_bytes, sent_resp_crc7, calc_resp_crc7;
+	u32 blksz_dwords =3D data_blksz >> 2, x32;
+	bool low_speed, data_read_done;
+	int ret =3D 0x0, i;
+
+	/* initial ok state, following are not pre-set by default */
+	pslot->sg_count =3D -1;
+	pslot->cmd_timeout =3D 0x0;
+	pslot->blk_buf_cycle_indx =3D pslot->blk_buf_nibble_indx =3D 0x0;
+	data_read_done =3D false;
+	/* clear crc_err/timeout */
+	readb(ts_sdmmc_host->base_iomem + 0x1);
+
+	/* low speed =3D sample on cmd-line, dat0-line */
+	low_speed =3D (pslot->sd_state & SD_LOWSPEED) ? true : false;
+
+	activate_slot_clk(ts_sdmmc_host, slot);
+
+	if (IS_ERR_OR_NULL(pslot->rw_dma_buf)) {
+		dev_warn(mmc_dev(ts_sdmmc_host->mmc_host),
+			 "%s|%d - Error, No allocated DMA read buffer %ld\n",
+			 __func__, __LINE__, PTR_ERR(pslot->rw_dma_buf));
+		*data_error =3D ret =3D -ENOMEM;
+		goto done;
+	}
+
+	if (!(cmd_flags & MMC_RSP_PRESENT)) {
+		dev_warn(
+			mmc_dev(ts_sdmmc_host->mmc_host),
+			"%s|%d - Error, read block command flgas must have a response\n",
+			__func__, __LINE__);
+		*cmd_error =3D ret =3D -EINVAL;
+	} else {
+		switch ((cmd_flags &
+			 (MMC_RSP_PRESENT | MMC_RSP_136 | MMC_RSP_CRC |
+			  MMC_RSP_BUSY | MMC_RSP_OPCODE))) {
+		case MMC_RSP_NONE:
+			resp_len_bytes =3D 0x0;
+			goto done;
+		case MMC_RSP_R1:
+		case MMC_RSP_R1B:
+		case MMC_RSP_R3:
+			resp_len_bytes =3D NORM_RESP_BYTES;
+			break;
+		case MMC_RSP_R2:
+			resp_len_bytes =3D LONG_RESP_BYTES;
+			break;
+		default:
+			dev_warn(mmc_dev(ts_sdmmc_host->mmc_host),
+				 "%s|%d - Warning, Invalid response type\n",
+				 __func__, __LINE__);
+			*cmd_error =3D ret =3D -EINVAL;
+			goto done;
+		}
+	}
+
+	/* serialize command */
+	spin_lock_bh(&ts_sdmmc_host->bh_lock);
+	send_serialize_cmd(ts_sdmmc_host, pslot, cmd_opcode, cmd_arg);
+	spin_unlock_bh(&ts_sdmmc_host->bh_lock);
+
+	/* wait for response, i.e. start bit=3D0 on slow sd_cmd */
+	mutex_lock(&ts_sdmmc_host->mutex_lock);
+	wait_for_response(ts_sdmmc_host, pslot, low_speed);
+	mutex_unlock(&ts_sdmmc_host->mutex_lock);
+
+	if (pslot->cmd_timeout >=3D MAX_RESP_TIMEOUT_MICROSECS) {
+		*cmd_error =3D ret =3D -ETIMEDOUT;
+		goto done;
+	}
+
+	/* serialize/consume cmd response */
+	spin_lock_bh(&ts_sdmmc_host->bh_lock);
+	sd_cmd_read(ts_sdmmc_host, pslot, resp_len_bytes, sizeof(u32));
+
+	spin_unlock_bh(&ts_sdmmc_host->bh_lock);
+
+	/* serialize/consume card's busy response if any */
+	if (cmd_flags & MMC_RSP_BUSY) {
+		stat =3D 0x0;
+		/* reset cmd time-out */
+		pslot->cmd_timeout =3D 0x0;
+
+		mutex_lock(&ts_sdmmc_host->mutex_lock);
+
+		while ((stat & 0x7) !=3D 0x7) {
+			if (pslot->cmd_timeout++ >=3D
+			    MAX_BUSY_TIMEOUT_MICROSECS) {
+				*cmd_error =3D ret =3D -ETIMEDOUT;
+				goto done;
+			}
+
+			/* toggle high slow clk-line */
+			writeb(CMDTRI_DATTRI_SDCLKH_SDCMDH_SDDATH,
+			       ts_sdmmc_host->base_iomem);
+
+			/* 1-delay reads */
+			if (low_speed)
+				add_1readb_delay(ts_sdmmc_host);
+
+			stat =3D stat << 1;
+			stat |=3D readb(ts_sdmmc_host->base_iomem) & 0x1;
+
+			/* toggle low slow clk-line */
+			writeb(CMDTRI_DATTRI_SDCLKL_SDCMDH_SDDATH,
+			       ts_sdmmc_host->base_iomem);
+
+			/* 1-delay reads */
+			if (low_speed)
+				add_1readb_delay(ts_sdmmc_host);
+
+			usleep_range(15, 25);
+		}
+
+		mutex_unlock(&ts_sdmmc_host->mutex_lock);
+	}
+
+	/* process response outside of spin locks */
+	if (cmd_flags & MMC_RSP_136) {
+		/* R2, copy 12-bytes/3-double-words of argument including internal CRC=
7 */
+		memcpy(&cmd_resp[0], &pslot->response[12], 0x4);
+		memcpy(&cmd_resp[1], &pslot->response[8], 0x4);
+		memcpy(&cmd_resp[2], &pslot->response[4], 0x4);
+		memcpy(&cmd_resp[3], &pslot->response[0], 0x4);
+	} else {
+		/* R1, R1b, R3, R4, R5, R6 4-bytes arguments only*/
+		memcpy(cmd_resp, &pslot->response[1], 0x4);
+	}
+
+	/* resp crc7 check */
+	switch ((cmd_flags & (MMC_RSP_PRESENT | MMC_RSP_136 | MMC_RSP_CRC |
+			      MMC_RSP_BUSY | MMC_RSP_OPCODE))) {
+	case MMC_RSP_R1:
+	case MMC_RSP_R1B:
+		sent_resp_crc7 =3D pslot->response[0] >> 1;
+		calc_resp_crc7 =3D ts7800v1_sdmmc_crc7(
+			0, &pslot->response[1], resp_len_bytes - 1, BE_ENDIAN);
+
+		if (sent_resp_crc7 !=3D calc_resp_crc7) {
+			*cmd_error =3D ret =3D -EILSEQ;
+			goto done;
+		}
+		break;
+	default:
+		/* no crc7 check*/
+		break;
+	}
+
+	spin_lock_bh(&ts_sdmmc_host->bh_lock);
+	send_sddat_start_nibble(ts_sdmmc_host);
+
+	for (i =3D 0; i < blksz_dwords; i++) {
+		memcpy(&x32, &pslot->rw_dma_buf[i << 2], sizeof(u32));
+
+		writel(x32, ts_sdmmc_host->base_iomem + SDCORE2_SDDATA_REG);
+	}
+
+	spin_unlock_bh(&ts_sdmmc_host->bh_lock);
+
+	*cmd_error =3D *data_error =3D ret =3D 0x0;
+
+done:
+
+	// 8 clocks before stopping
+	spin_lock_bh(&ts_sdmmc_host->bh_lock);
+
+	if (low_speed)
+		for (i =3D 0; i < 8; i++) {
+			/* toggle hi slow clk-line */
+			writeb(CMDTRI_DATTRI_SDCLKH_SDCMDH_SDDATH,
+			       ts_sdmmc_host->base_iomem);
+			/* 2-delay reads */
+			add_2readb_delay(ts_sdmmc_host);
+
+			/* toggle low slow clk-line */
+			writeb(CMDTRI_DATTRI_SDCLKL_SDCMDH_SDDATH,
+			       ts_sdmmc_host->base_iomem);
+			/* 2-delay reads */
+			add_2readb_delay(ts_sdmmc_host);
+		}
+	else {
+		/* send 8-bits on fast clk-line */
+		writeb(0xff, ts_sdmmc_host->base_iomem + SDCORE2_SDCMD_REG);
+	}
+
+	spin_unlock_bh(&ts_sdmmc_host->bh_lock);
+
+	return ret;
+}
+
+static void ts7800v1_sdmmc_request(struct mmc_host *mmc,
+				   struct mmc_request *mmc_req)
+{
+	struct ts7800v1_sdmmc_host *ts_sdmmc_host =3D mmc_priv(mmc);
+	struct mmc_command *req_cmd =3D mmc_req->cmd;
+	struct mmc_command *sbc_cmd =3D mmc_req->sbc;
+	struct mmc_command *stop_cmd =3D mmc_req->stop;
+
+	if (req_cmd !=3D NULL) {
+		if (req_cmd->data !=3D NULL &&
+		    ((req_cmd->data->flags & MMC_DATA_READ) ||
+		     (req_cmd->data->flags & MMC_DATA_WRITE))) {
+			struct ts7800v1_sdmmc_slot *pslot =3D
+				&ts_sdmmc_host->sd_slot[SD_ACTIVE_SLOT];
+			u32 blocks;
+
+			enum dma_data_direction dma_data_dir =3D
+				mmc_get_dma_dir(req_cmd->data);
+			if (dma_data_dir =3D=3D DMA_NONE) {
+				dev_err(mmc_dev(ts_sdmmc_host->mmc_host),
+					"%s|%d - Invalid data direction %d\n",
+					__func__, __LINE__, dma_data_dir);
+				req_cmd->error =3D req_cmd->data->error =3D -EINVAL;
+				goto mmc_request_done;
+			}
+
+			if (IS_ERR_OR_NULL(pslot)) {
+				dev_err(mmc_dev(ts_sdmmc_host->mmc_host),
+					"%s|%d - no valid slot selected!\n",
+					__func__, __LINE__);
+				req_cmd->error =3D req_cmd->data->error =3D -EINVAL;
+				goto mmc_request_done;
+			}
+
+			pslot->sg_count =3D -1;
+			blocks =3D (req_cmd->data->blksz * req_cmd->data->blocks);
+
+			pslot->rw_dma_buf =3D
+				kzalloc(blocks * sizeof(u8), GFP_KERNEL);
+			if (IS_ERR_OR_NULL(pslot->rw_dma_buf)) {
+				dev_err(mmc_dev(ts_sdmmc_host->mmc_host),
+					"%s|%d - kzalloc 'rw_dma_buf' size %u failed with %ld\n",
+					__func__, __LINE__, blocks,
+					PTR_ERR(pslot->rw_dma_buf));
+				req_cmd->error =3D req_cmd->data->error =3D -ENOMEM;
+				goto done;
+			}
+
+			pslot->sg_count =3D dma_map_sg(
+				mmc_dev(mmc_from_priv(ts_sdmmc_host)),
+				req_cmd->data->sg, req_cmd->data->sg_len,
+				dma_data_dir);
+
+			if (pslot->sg_count =3D=3D 0) {
+				req_cmd->error =3D req_cmd->data->error =3D -ENOSPC;
+				goto done;
+			}
+
+			req_cmd->data->sg_count =3D pslot->sg_count;
+
+			if (req_cmd->data->flags & MMC_DATA_READ) {
+				/* check request data state */
+
+				if (sbc_cmd !=3D NULL) {
+					sbc_cmd->error =3D
+						send_cmd_recv_resp_simple(
+							ts_sdmmc_host,
+							SD_ACTIVE_SLOT,
+							sbc_cmd->opcode,
+							sbc_cmd->arg,
+							sbc_cmd->flags,
+							&sbc_cmd->error,
+							sbc_cmd->resp);
+					if (sbc_cmd->error) {
+						dev_err(mmc_dev(ts_sdmmc_host
+									->mmc_host),
+							"%s|%d - sbc command failed with error %d!\n",
+							__func__, __LINE__,
+							sbc_cmd->error);
+
+						req_cmd->error =3D
+							req_cmd->data->error =3D
+								sbc_cmd->error;
+						goto done;
+					}
+				}
+
+				req_cmd->error =3D send_cmd_recv_resp_read_blk(
+					ts_sdmmc_host, SD_ACTIVE_SLOT,
+					req_cmd->opcode, req_cmd->arg,
+					req_cmd->flags, &req_cmd->error,
+					req_cmd->resp, blocks, 0,
+					&req_cmd->data->error);
+
+				/*
+				 * fpga controller bug workaround, simply re-issue command
+				 * This happens with some cards when querying their supported
+				 * function groups prior to swtiching to high speed mode
+				 */
+				if (req_cmd->error && req_cmd->opcode =3D=3D 0x6)
+					req_cmd->error =3D
+						send_cmd_recv_resp_read_blk(
+							ts_sdmmc_host,
+							SD_ACTIVE_SLOT,
+							req_cmd->opcode,
+							req_cmd->arg,
+							req_cmd->flags,
+							&req_cmd->error,
+							req_cmd->resp, blocks,
+							0,
+							&req_cmd->data->error);
+
+				if (req_cmd->error !=3D 0x0 ||
+				    req_cmd->data->error !=3D 0x0)
+					goto done;
+
+				req_cmd->data->bytes_xfered +=3D blocks;
+
+				/* Send stop-transmission command if requested */
+				if (stop_cmd !=3D NULL && sbc_cmd =3D=3D NULL) {
+					stop_cmd->error =3D
+						send_cmd_recv_resp_simple(
+							ts_sdmmc_host,
+							SD_ACTIVE_SLOT,
+							stop_cmd->opcode,
+							stop_cmd->arg,
+							stop_cmd->flags,
+							&stop_cmd->error,
+							stop_cmd->resp);
+
+					if (stop_cmd->error) {
+						dev_err(mmc_dev(ts_sdmmc_host
+									->mmc_host),
+							"%s|%d - stop command failed with error %d!\n",
+							__func__, __LINE__,
+							stop_cmd->error);
+
+						goto done;
+					}
+				}
+
+				/* mem-to-mem dma using SoC controller */
+					sg_copy_from_buffer(
+						req_cmd->data->sg,
+						req_cmd->data->sg_len,
+						pslot->rw_dma_buf, blocks);
+
+			} else { /* MMC_DATA_WRITE */
+				/* copy user data, mem-to-mem dma using SoC controller */
+				sg_copy_to_buffer(req_cmd->data->sg,
+						  req_cmd->data->sg_len,
+						  pslot->rw_dma_buf, blocks);
+
+				/* check request data state */
+
+				if (sbc_cmd !=3D NULL) {
+					sbc_cmd->error =3D
+						send_cmd_recv_resp_simple(
+							ts_sdmmc_host,
+							SD_ACTIVE_SLOT,
+							sbc_cmd->opcode,
+							sbc_cmd->arg,
+							sbc_cmd->flags,
+							&sbc_cmd->error,
+							sbc_cmd->resp);
+					if (sbc_cmd->error) {
+						dev_err(mmc_dev(ts_sdmmc_host
+									->mmc_host),
+							"%s|%d - sbc command failed with error %d!\n",
+							__func__, __LINE__,
+							sbc_cmd->error);
+
+						req_cmd->error =3D
+							req_cmd->data->error =3D
+								sbc_cmd->error;
+						goto done;
+					}
+				}
+
+				req_cmd->error =3D send_cmd_recv_resp_write_blk(
+					ts_sdmmc_host, SD_ACTIVE_SLOT,
+					req_cmd->opcode, req_cmd->arg,
+					req_cmd->flags, &req_cmd->error,
+					req_cmd->resp, blocks, 0,
+					&req_cmd->data->error);
+
+				if (req_cmd->error !=3D 0x0 ||
+				    req_cmd->data->error !=3D 0x0)
+					goto done;
+
+				req_cmd->data->bytes_xfered +=3D blocks;
+
+				/* Send stop-transmission command if requested */
+				if (stop_cmd !=3D NULL && sbc_cmd =3D=3D NULL) {
+					stop_cmd->error =3D
+						send_cmd_recv_resp_simple(
+							ts_sdmmc_host,
+							SD_ACTIVE_SLOT,
+							stop_cmd->opcode,
+							stop_cmd->arg,
+							stop_cmd->flags,
+							&stop_cmd->error,
+							stop_cmd->resp);
+
+					if (stop_cmd->error) {
+						dev_err(mmc_dev(ts_sdmmc_host
+									->mmc_host),
+							"%s|%d - stop command failed with error %d!\n",
+							__func__, __LINE__,
+							stop_cmd->error);
+						goto done;
+					}
+				}
+			}
+
+done:
+			if (pslot->sg_count > 0) {
+				dma_unmap_sg(
+					mmc_dev(mmc_from_priv(ts_sdmmc_host)),
+					req_cmd->data->sg,
+					req_cmd->data->sg_len, dma_data_dir);
+				pslot->sg_count =3D -1;
+			}
+
+			if (!IS_ERR_OR_NULL(pslot->rw_dma_buf)) {
+				kfree(pslot->rw_dma_buf);
+				pslot->rw_dma_buf =3D NULL;
+			}
+
+		} else {
+			req_cmd->error =3D send_cmd_recv_resp_simple(
+				ts_sdmmc_host, SD_ACTIVE_SLOT, req_cmd->opcode,
+				req_cmd->arg, req_cmd->flags, &req_cmd->error,
+				req_cmd->resp);
+
+			/* fpga controller bug workaround, simply re-issue command
+			 * This happens with some cards when querying their supported
+			 * function groups prior to swtiching to high speed mode
+			 */
+			if (req_cmd->error && req_cmd->opcode =3D=3D 0x6)
+				req_cmd->error =3D send_cmd_recv_resp_simple(
+					ts_sdmmc_host, SD_ACTIVE_SLOT,
+					req_cmd->opcode, req_cmd->arg,
+					req_cmd->flags, &req_cmd->error,
+					req_cmd->resp);
+		}
+	}
+
+mmc_request_done:
+	mmc_request_done(mmc, mmc_req);
+}
+
+static void ts7800v1_sdmmc_host_init(struct ts7800v1_sdmmc_host *ts_sdmm=
c_host)
+{
+	ts_sdmmc_host->hw_version =3D ts7800v1_sdmmc_hw_version(ts_sdmmc_host);
+	card_reset(ts_sdmmc_host, SD_ACTIVE_SLOT);
+}
+
+static void ts7800v1_sdmmc_set_ios(struct mmc_host *mmc, struct mmc_ios =
*ios)
+{
+	/* change
+	 * power supply mode,
+	 * data bus width,
+	 * timing specification used, such as: MMC_TIMING_LEGACY,
+	 * MMC_TIMING_MMC_HS, MMC_TIMING_UHS_SDR12, etc
+	 * signalling voltage (1.8V or 3.3V),
+	 * driver type (A, B, C, D)
+	 */
+
+	struct ts7800v1_sdmmc_host *ts_sdmmc_host =3D mmc_priv(mmc);
+	struct ts7800v1_sdmmc_slot *pslot =3D
+		&ts_sdmmc_host->sd_slot[SD_ACTIVE_SLOT];
+
+	switch (ios->timing) {
+	case MMC_TIMING_LEGACY:
+		set_clkspd(ts_sdmmc_host, pslot, false /*slow*/);
+		break;
+
+	case MMC_TIMING_MMC_HS:
+	case MMC_TIMING_SD_HS:
+	default:
+		set_clkspd(ts_sdmmc_host, pslot, true /*fast*/);
+	}
+
+	switch (ios->bus_width) {
+	case MMC_BUS_WIDTH_4:
+		pslot->sd_state |=3D DATSSP_4BIT;
+		set_mlt_rdwr(ts_sdmmc_host, pslot, true /* multi */);
+
+		break;
+	default:
+		/* keep default 1 bit mode */
+		pslot->sd_state &=3D ~DATSSP_4BIT;
+		set_mlt_rdwr(ts_sdmmc_host, pslot, false);
+	}
+}
+
+static int ts7800v1_sdmmc_card_busy(struct mmc_host *mmc)
+{
+	struct ts7800v1_sdmmc_host *ts_sdmmc_host =3D mmc_priv(mmc);
+	u8 stat, a, i;
+
+	stat =3D 0x0;
+	for (i =3D 0; i < 8; i++) {
+		/* toggle high slow clk-line */
+		writeb(CMDTRI_DATTRI_SDCLKH_SDCMDH_SDDATH,
+		       ts_sdmmc_host->base_iomem);
+
+		/* 1-delay reads */
+		a =3D readb(ts_sdmmc_host->base_iomem);
+
+		/* look for 3-consecutive dat0 =3D 1 */
+		stat =3D stat << 1;
+		/* check dat0 for busy bit=3D1 */
+		stat |=3D readb(ts_sdmmc_host->base_iomem) & 0x1;
+
+		writeb(CMDTRI_DATTRI_SDCLKL_SDCMDH_SDDATH,
+		       ts_sdmmc_host->base_iomem);
+
+		/* 1-delay reads */
+		a =3D readb(ts_sdmmc_host->base_iomem);
+
+		if ((stat & 0x7) =3D=3D 0x7)
+			break;
+	}
+
+	stat &=3D GENMASK(3, 0);
+	return !(stat =3D=3D GENMASK(3, 0));
+}
+
+static void ts7800v1_sdmmc_hw_reset(struct mmc_host *mmc)
+{
+	struct ts7800v1_sdmmc_host *ts_sdmmc_host =3D mmc_priv(mmc);
+
+	card_reset(ts_sdmmc_host, SD_ACTIVE_SLOT);
+}
+
+/*
+ * 0 for a read/write card
+ * 1 for a read-only card
+ */
+static int ts7800v1_sdmmc_get_ro(struct mmc_host *mmc)
+{
+	struct ts7800v1_sdmmc_host *ts_sdmmc_host =3D mmc_priv(mmc);
+
+	return ts_sdmmc_host->sd_slot[SD_ACTIVE_SLOT].sd_wprot;
+}
+
+/*
+ * 0 for a absent card
+ * 1 for a present card
+ */
+static int ts7800v1_sdmmc_get_cd(struct mmc_host *mmc)
+{
+	struct ts7800v1_sdmmc_host *ts_sdmmc_host =3D mmc_priv(mmc);
+
+	return ts_sdmmc_host->sd_slot[SD_ACTIVE_SLOT].sd_detect;
+}
+
+static const struct mmc_host_ops ts7800v1_sdmmc_host_ops =3D {
+	.request =3D ts7800v1_sdmmc_request,
+	.set_ios =3D ts7800v1_sdmmc_set_ios,
+	.get_ro =3D ts7800v1_sdmmc_get_ro,
+	.get_cd =3D ts7800v1_sdmmc_get_cd,
+	.card_busy =3D ts7800v1_sdmmc_card_busy,
+	.card_hw_reset =3D ts7800v1_sdmmc_hw_reset,
+};
+
+static int ts7800v1_sdmmc_probe(struct platform_device *pdev)
+{
+	struct ts7800v1_sdmmc_host *ts_sdmmc_host =3D NULL;
+	struct mmc_host *mmc_host =3D NULL;
+	struct resource *mem_res =3D NULL, *irq_res =3D NULL;
+	int ret;
+
+	mmc_host =3D
+		mmc_alloc_host(sizeof(struct ts7800v1_sdmmc_host), &pdev->dev);
+	if (IS_ERR_OR_NULL(mmc_host)) {
+		dev_err(&pdev->dev,
+			"%s|%d - Failed to allocate mmc host, error %ld\n",
+			__func__, __LINE__, PTR_ERR(mmc_host));
+		ret =3D -ENOMEM;
+		goto err_alloc_host;
+	}
+
+	ts_sdmmc_host =3D mmc_priv(mmc_host);
+	ts_sdmmc_host->mmc_host =3D mmc_host;
+	ts_sdmmc_host->base_iomem =3D NULL;
+
+	spin_lock_init(&ts_sdmmc_host->bh_lock);
+	mutex_init(&ts_sdmmc_host->mutex_lock);
+
+	mem_res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
+					       "ts_sdmmc_ctrl");
+	if (IS_ERR_OR_NULL(mem_res)) {
+		dev_err(&pdev->dev,
+			"%s|%d - Failed to get platform memory resource, error %ld\n",
+			__func__, __LINE__, PTR_ERR(mem_res));
+		ret =3D -ENXIO;
+		goto pltfrm_get_res_mem_err;
+	}
+
+	ts_sdmmc_host->base_iomem =3D devm_ioremap_resource(&pdev->dev, mem_res=
);
+	if (IS_ERR_OR_NULL(ts_sdmmc_host->base_iomem)) {
+		dev_err(&pdev->dev,
+			"%s|%d - Failed to IO map resource %s, error %ld\n",
+			__func__, __LINE__, mem_res->name,
+			PTR_ERR(ts_sdmmc_host->base_iomem));
+		ret =3D -EBUSY;
+		goto devm_ioremap_res_mem_err;
+	}
+
+	irq_res =3D platform_get_resource_byname(pdev, IORESOURCE_IRQ,
+					       "ts_sdmmc_sdbusy");
+	if (IS_ERR_OR_NULL(irq_res)) {
+		dev_err(&pdev->dev,
+			"%s|%d - Failed to get irq resource, error %ld\n",
+			__func__, __LINE__, PTR_ERR(irq_res));
+		ret =3D -ENXIO;
+		goto pltfrm_get_res_irq_err;
+	}
+
+	/* ensure 4-bit bus_width (only width supported by hardware) */
+	mmc_host->caps &=3D ~MMC_CAP_8_BIT_DATA;
+	mmc_host->caps |=3D MMC_CAP_4_BIT_DATA;
+
+	/* controller does not auto-generate CMD23 */
+	mmc_host->caps &=3D ~MMC_CAP_CMD23;
+
+	mmc_host->max_blk_count =3D MAX_BLK_COUNT;
+	mmc_host->max_blk_size =3D MAX_BLK_SIZE;
+	mmc_host->max_req_size =3D
+		mmc_host->max_blk_count * mmc_host->max_blk_size;
+	mmc_host->max_segs =3D MAX_SEGS;
+	mmc_host->max_seg_size =3D MAX_SEG_SIZE;
+	dma_set_max_seg_size(&pdev->dev, mmc_host->max_seg_size);
+
+	/* Set default capabilities */
+	mmc_host->caps |=3D MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_MMC_HIGHSPEED |
+			  MMC_CAP_SD_HIGHSPEED;
+
+	mmc_host->ocr_avail =3D MMC_VDD_32_33 | MMC_VDD_33_34;
+
+	mmc_host->ops =3D &ts7800v1_sdmmc_host_ops;
+
+	ts7800v1_sdmmc_host_init(ts_sdmmc_host);
+
+	platform_set_drvdata(pdev, ts_sdmmc_host);
+
+	ret =3D mmc_add_host(mmc_host);
+	if (ret !=3D 0) {
+		dev_err(&pdev->dev,
+			"%s|%d - Failed to add TS-7800v1 SD/MMC host controller, error %d\n",
+			__func__, __LINE__, ret);
+		goto err_mmc_add_host;
+	}
+
+	dev_info(&pdev->dev,
+		 "TS-7800v1 FPGA based SD/MMC Controller initialized\n");
+
+	return 0;
+
+err_mmc_add_host:
+	devm_free_irq(&pdev->dev, ts_sdmmc_host->sdbusy_irq, ts_sdmmc_host);
+pltfrm_get_res_irq_err:
+	devm_iounmap(&pdev->dev, ts_sdmmc_host->base_iomem);
+devm_ioremap_res_mem_err:
+pltfrm_get_res_mem_err:
+	mutex_destroy(&ts_sdmmc_host->mutex_lock);
+	mmc_free_host(mmc_host);
+err_alloc_host:
+	return ret;
+}
+
+static int ts7800v1_sdmmc_remove(struct platform_device *pdev)
+{
+	struct ts7800v1_sdmmc_host *ts_sdmmc_host =3D platform_get_drvdata(pdev=
);
+
+	mutex_destroy(&ts_sdmmc_host->mutex_lock);
+	mmc_remove_host(ts_sdmmc_host->mmc_host);
+	if (!IS_ERR_OR_NULL(ts_sdmmc_host->mmc_host))
+		mmc_free_host(ts_sdmmc_host->mmc_host);
+
+	dev_info(&pdev->dev,
+		 "TS-7800v1 FPGA based SD/MMC controller removed\n");
+
+	return 0;
+}
+
+static const struct platform_device_id ts7800v1_sdmmc_ids[] =3D {
+	{
+		.name =3D DRIVER_NAME,
+	},
+	{
+		/* sentinel */
+	}
+};
+
+MODULE_DEVICE_TABLE(platform, ts7800v1_sdmmc_ids);
+
+static struct platform_driver ts7800v1_sdmmc_driver =3D {
+	.probe =3D ts7800v1_sdmmc_probe,
+	.remove =3D ts7800v1_sdmmc_remove,
+	.id_table	=3D ts7800v1_sdmmc_ids,
+	.driver =3D {
+		.name =3D DRIVER_NAME,
+		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
+	},
+};
+
+module_platform_driver(ts7800v1_sdmmc_driver);
+
+MODULE_DESCRIPTION("TS-7800v1 FPGA based MMC Driver");
+MODULE_AUTHOR("Firas Ashkar <firas.ashkar@savoirfairelinux.com>");
+MODULE_LICENSE("GPL");
--=20
2.34.1

