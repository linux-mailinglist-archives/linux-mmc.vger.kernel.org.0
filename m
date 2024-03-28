Return-Path: <linux-mmc+bounces-1615-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF49288FA45
	for <lists+linux-mmc@lfdr.de>; Thu, 28 Mar 2024 09:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F02B41C29369
	for <lists+linux-mmc@lfdr.de>; Thu, 28 Mar 2024 08:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9FA50A97;
	Thu, 28 Mar 2024 08:49:34 +0000 (UTC)
X-Original-To: linux-mmc@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3B738396
	for <linux-mmc@vger.kernel.org>; Thu, 28 Mar 2024 08:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711615774; cv=none; b=tF10uxWLUboQaENcxJgwMw57sg8oI8wx4Ir7nH3/lgimCA+uowG1h8PoAPd6HWBSO+iLfY0/MzZueTxIieg2/nedG7hQBgjLx0lpu1D4OwHzM7+Op9+dpmEORup4tlyVo/hTxuxwHiQKN21neu5638DztSFBdnvs2bbV6fIrSpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711615774; c=relaxed/simple;
	bh=EBorZXRrWjbuaFvKzTUEoozM5GVNBh/alZ7S9giMa3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mBFEy9YHD0+ceEfNgYjpIbEh9q3ayzFNSBGmF/aXmiMuUlSGWedPQv5ZxYmhpM9LJuQ6tVH3yTo1Ko4htpsL3haqMsTSgjy5OHebuOQYZnrKDTj9JZ1Q/jWDbKPQT4BpzDSHL70GdYX6L60lx4oRk3uRlS+tI/u91JDjdEqjYyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB5932F4;
	Thu, 28 Mar 2024 01:50:05 -0700 (PDT)
Received: from [10.1.35.17] (e133047.arm.com [10.1.35.17])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 042E33F7BD;
	Thu, 28 Mar 2024 01:49:30 -0700 (PDT)
Message-ID: <3de8a6da-020f-45f1-a228-006db8f925ac@arm.com>
Date: Thu, 28 Mar 2024 08:49:29 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc-utils: man 1 mmc-utils
To: Avri Altman <avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 linux-mmc@vger.kernel.org
References: <20240327184528.788-1-avri.altman@wdc.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20240327184528.788-1-avri.altman@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/03/2024 18:45, Avri Altman wrote:
> I have put together a draft man page for mmc-utils.  The contents are
> from mmc-utils help documents and edited for brevity.  The point is not
> to replace the existing docmentation, but to serve as a quick reference.
> 
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> ---
> 
> Changelog:
> v1->v2: Fix some spelling mistakes
> ---
>  Makefile |   9 +-
>  mmc.1    | 308 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 312 insertions(+), 5 deletions(-)
>  create mode 100644 mmc.1
> 
> diff --git a/Makefile b/Makefile
> index 10b78ab..a890833 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -21,6 +21,7 @@ prefix ?= /usr/local
>  bindir = $(prefix)/bin
>  LIBS=
>  RESTORE_LIBS=
> +mandir = /usr/share/man
>  
>  progs = mmc
>  
> @@ -29,7 +30,7 @@ ifdef C
>  	check = sparse $(CHECKFLAGS)
>  endif
>  
> -all: $(progs) manpages
> +all: $(progs)
>  
>  .c.o:
>  ifdef C
> @@ -43,16 +44,14 @@ mmc: $(objects)
>  manpages:
>  	$(MAKE) -C man
>  
> -install-man:
> -	$(MAKE) -C man install
> -
>  clean:
>  	rm -f $(progs) $(objects)
>  	$(MAKE) -C man clean
>  
> -install: $(progs) install-man
> +install: $(progs)
>  	$(INSTALL) -m755 -d $(DESTDIR)$(bindir)
>  	$(INSTALL) $(progs) $(DESTDIR)$(bindir)
> +	$(INSTALL) -m 644 mmc.1 $(DESTDIR)$(mandir)/man1
>  
>  -include $(foreach obj,$(objects), $(dir $(obj))/.$(notdir $(obj)).d)
>  
> diff --git a/mmc.1 b/mmc.1
> new file mode 100644
> index 0000000..888b8b6
> --- /dev/null
> +++ b/mmc.1
> @@ -0,0 +1,308 @@
> +.TH mmc\-utils 1 "April 2024" "User Manual"
> +.SH NAME
> +mmc \-  a tool for configuring MMC storage devices
> +.SH SYNOPSIS
> +.B mmc
> +[\fIoptions\fR] [\ mmc\-block\-device\fR]...
> +.SH DESCRIPTION
> +.B mmc-utils
> +is a single-threaded tool that will perform a particular type of mmc action as specified by the user.
> +.br
> +The typical use of mmc-utils is to access the mmc device either for configuring or reading its configuration registers.
> +.SH OPTIONS
> +.TP
> +.BI extcsd " " read " " \fIdevice\fR
> +Read and prints the extended csd register
> +.TP
> +.BI extcsd " " write " " \fIoffset\fR " " \fIvalue\fR " " \fIdevice\fR
> +Write \fIvalue\fR at \fIoffset\fR to the device's extcsd
> +.TP
> +.BI writeprotect " " boot " " get " " \fIdevice\fR
> +Print the boot partitions write protect status
> +.TP
> +.BI writeprotect " " boot " " set " " \fIdevice\fR " " [\fInumber\fR]
> +Set the boot partition write protect status for the device.
> +.br
> +If \fInumber\fR is passed (0 or 1), only protect that particular eMMC boot partition, otherwise protect both.
s/particular/specified/?
> +.br
> +It will be write-protected until the next boot.
> +.TP
> +.BI writeprotect " " user " " set " " \fItype\fR " " \fIstart\-block\fR " " \fIblocks\fR " " \fIdevice\fR
> +Set the write protect configuration for the specified region of the user area for the device.
> +.br
> +\fIstart\-block\fR specifies the first block of the protected area.
> +.br
> +\fIblocks\fR specifies the size of the protected area in blocks.
> +.br
> +NOTE! The area must start and end on Write Protect Group boundaries, Use the "writeprotect user get" command to get the Write Protect Group size.
> + \fItype\fR is one of the following:
> +.RS
> +.RS
> +.TP
> +.B none
> +Clear temporary write protection.
> +.TP
> +.B temp
> +Set temporary write protection.
> +.TP
> +.B pwron
> +Set write protection until the next power on.
> +.RE
> +.RE
> +.TP
> +.BI writeprotect " " user " " get " " \fIdevice\fR
> +Print the user areas write protect configuration for the device.
s/areas/area's
> +.TP
> +.BI disable " " 512B " " emulation " " \fIdevice\fR
> +Set the eMMC data sector size to 4KB by disabling emulation on the device.
> +.TP
> +.BI gp " " create " " \fIdry\-run\fR " " \fIlength\-KiB\fR " " \fIpartition\fR  " " \fIenh\-attr\fR " " \fIext\-attr\fR " " \fIdevice\fR
> +Create general purpose partition for the the device.
> +.br
> +NOTE!  This is a one-time programmable (unreversible) change.
> +.br
> +To set enhanced attribute to general partition being created set \fIenh\-attr\fR to 1 else set it to 0.
> +.br
> +To set extended attribute to general partition set \fIenh\-attr\fR to 1,2 else set it to 0.
> +.br
> +\fIdry\-run\fR is one of the following:
> +.RS
> +.RS
> +.TP
> +.B \-y
> +PARTITION_SETTING_COMPLETED in the extcsd will get set and the partisioning operation will take effect and finalized.
s/partisioning/partitioning
s/and finalized/and be finalized/?
> +.TP
> +.B \-c
> +more partitioning settings are still to come - partitioning operation will not take effect.
> +.TP
> +.B otherwise
> +These changes will not take effect neither now nor after a power cycle.
> +.RE
> +.RE
> +.TP
> +.BI enh_area " " set " " \fIdry\-run\fR " " \fIstart\-KiB\fR " " \fIlength\-KiB\fR " " \fIdevice\fR
> +Enable the enhanced user area for the device.
> +.br
> +NOTE!  This is a one-time programmable (unreversible) change.
s/unreversible/irreversible
> +\fIdry\-run\fR is as above.
> +.TP
> +.BI write_reliability " " set " " " \fIdry\-run\fR " " \fIpartition\fR " " \fIdevice\fR
> +Enable write reliability per partition for the device.
> +.br
> +NOTE!  This is a one-time programmable (unreversible) change.
s/unreversible/irreversible
> +\fIdry\-run\fR is as above.
> +.TP
> +.BI status " " get " " \fIdevice\fR
> +Print the response to STATUS_SEND (CMD13).
> +.TP
> +.BI bootpart " " enable " " \fIboot\-partition\fR " " \fIsend\-ackn\fR " " \fIdevice\fR
> +Enable the boot partition for the device.
> +Disable the boot partition for the device if is \fIboot\-partition\fR set to 0.
> +.br
> +To receive acknowledgment of boot from the card set \fIsend\-ackn\fR to 1, else set it to 0.
> +.TP
> +.BI bootbus " " set " " \fIboot\-mode\fR " " \fIreset\-boot\-bus\-conditions\fR " " \fIboot\-bus\-width\fR " " \fIdevice\fR
> +Set Boot Bus Conditions.
> +.br
> +\fIboot\-mode\fR is one of the following: single_backward, single_hs, or dual.
> +.br
> +\fIreset\-boot\-bus\-conditions\fR is one of the following: x1 or retain.
> +.br
> +\fIboot\-bus\-width\fR is one of the following: x1, x4, or x8.
> +.TP
> +.BI bkops_en " " \fImode\fR " " \fIdevice\fR
> +Enable the eMMC BKOPS feature on the device.
> +The auto (AUTO_EN) setting is only supported on eMMC 5.0 or newer.
> +.br
> +NOTE!  Setting manual (MANUAL_EN) is one-time programmable (unreversible) change.
s/unreversible/irreversible
> +.br
> +\fImode\fR is one of the following:
> +.RS
> +.RS
> +.TP
> +.B auto
> +Auto backops is set
> +.TP
> +.B manual
> +Manual bkops is set
> +.RE
> +.RE
> +.TP
> +.BI hwreset " " enable " " \fIdevice\fR
> +Permanently enable the eMMC H/W Reset feature on the device.
> +.br
> +NOTE!  This is a one-time programmable (unreversible) change.
s/unreversible/irreversible
> +.TP
> +.BI hwreset " " disable " " \fIdevice\fR
> +Permanently disable the eMMC H/W Reset feature on the device.
> +.br
> +NOTE!  This is a one-time programmable (unreversible) change.
s/unreversible/irreversible
> +.TP
> +.BI sanitize " " \fIdevice\fR " " \fI[timeout_ms]\fR
> +Send Sanitize command to the device.
> +This will delete the unmapped memory region of the device.
> +.TP
> +.BI rpmb " " write\-key " " \fIrpmb\-device\fR " " \fIkey\-file\fR
> +Program authentication key which is 32 bytes length and stored in the specified file.
> +.br
> +Also you can specify '-' instead of key file path to read the key from stdin.
> +.br
> +NOTE!  This is a one-time programmable (unreversible) change.
s/unreversible/irreversible
> +.TP
> +.BI rpmb " " read\-counter " " \fIrpmb\-device\fR
> +Counter value for the \fIrpmb\-device\fR will be read to stdout.
> +.TP
> +.BI rpmb " " read\-block " " \fIrpmb\-device\fR " " \fIaddress\fR " " \fIblocks-\count\fR " " \fIoutput-\file\fR " " [\fIkey\-file\fR]
> +Blocks of 256 bytes will be read from \fIrpmb\-device\fR to output
> +file or stdout if '-' is specified. If key is specified - read
> +data will be verified.
> +.TP
> +.BI rpmb " " write\-block " " \fIrpmb\-device\fR " " \fIaddress\fR " "  \fI256\-byte\-data\-file\fR " " \fIkey\-file\fR
> +Block of 256 bytes will be written from data file to
> +\fIrpmb\-device\fR. 
> +.br
> +Also you can specify '-' instead of key file path or data file to read the data from stdin.
> +.TP
> +.BI cache " " enable " " \fIdevice\fR
> +Enable the eMMC cache feature on the device.
> +.br
> +NOTE! The cache is an optional feature on devices >= eMMC4.5.
> +.TP
> +.BI cache disable " " \fIdevice\fR
> +Disable the eMMC cache feature on the device.
> +.br
> +NOTE! The cache is an optional feature on devices >= eMMC4.5.
> +.TP
> +.BI csd " " read " " \fidevice\-path\fR
> +Print CSD data from \fIdevice\-path\fR.
> +The device path should specify the csd sysfs file directory.
> +.TP
> +.BI cid " " read " " \fIdevice\-path\fR
> +Print CID data from \fIdevice\-path\fR.
> +The device path should specify the cid sysfs file directory.
> +.TP
> +.BI scr " " read " " \fIdevice\-path\fR
> +Print SCR data from \fIdevice\-path\fR.
> +The device path should specify the scr sysfs file directory.
> +.TP
> +.BI ffu " " \fIimage\-file\-name\fR " " \fIdevice\fR " " [\fIchunk\-bytes\fR]
> +Run Field Firmware Update with \fIimage\-file\-name\fR on the device.
> +.br
> +[\fIchunk\-bytes\fR] is optional and defaults to its max - 512k. should be in decimal bytes and sector aligned.
> +.br
> +if [\fIchunk\-bytes\fR] is omitted, mmc-utils will try to run ffu using the largest possible chunks: max(image-file, 512k).
> +.TP
> +.BI erase " " \fItype\fR " " \fIstart-address\fR " " \fIend\-address\fR " " \fIdevice\fR
> +Send Erase CMD38 with specific argument to the device.
> +.br
> +NOTE!: This will delete all user data in the specified region of the device.
> +.br
> +\fItype\fR is one of the following: legacy, discard, secure-erase, secure-trim1, secure-trim2, or trim.
> +.TP
> +.BI gen_cmd " " read " \fidevice\fR [\fIarg\fR]
> +Send GEN_CMD (CMD56) to read vendor-specific format/meaning data from the device.
> +.br
> +NOTE!: [\fIarg\fR] is optional and defaults to 0x1. If [\fIarg\fR] is specified, then [\fIarg\fR]
> +must be a 32-bit hexadecimal number, prefixed with 0x/0X. And bit0 in [\fIarg\fR] must be 1.
> +Normally this command is aimed to extract a device-health info from the device.
> +.TP
> +.BI softreset " " \fIdevice\fR
> +Issues a CMD0 softreset, e.g. for testing if hardware reset for UHS works
> +.TP
> +.BI boot_operation " " \fIboot\-data\-file\fR " " \fIdevice\fR
> + Does the alternative boot operation and writes the specified starting blocks of boot data into the requested file.
> +Note some limitations:
> +.RS
> +.RS
> +.TP
> +.B 1)
> +The boot operation must be configured first, e.g. via bootbus and/or bootpart commands
> +.TP
> +.B 2) 
> +The MMC must currently be running at the bus mode that is configured for the boot operation (HS200 and HS400 not supported at all).
> +.TP
> +.B 3)
> +Only up to 512K bytes of boot data will be transferred.
> +.TP
> +.B 4)
> +The MMC will perform a soft reset, if your system cannot handle that do not use the boot operation from mmc-utils.
> +.RE
> +.RE
> +.TP
> +.BI \-\-help " " | " " help " " | " " \-h
> +Show the help
> +.TP
> +.BI \fIcmd\fR " " \-\-help
> +Show detailed help for that specific \fIcmd\fR or subset of commands.
> +.SH "RPMB COMMANDS"
> +The RPMB partition on the eMMC devices is a special area used for storing cryptographically safe information signed by a
> +special secret key.
> +.br
> +To write and read records from this special area, authentication is needed.
> +.br
> +The RPMB area is *only* and *exclusively* accessed using ioctl()s from user-space.
> +.br
> +RPMB commands are send using the mmc multi-ioctl, thus ensures that the atomic nature of the rpmb access operation.
> +.br
> +The rpmb device given as a parameter to the rpmb commands is not a block device but a char device.
> +.br
> +This was done to help the mmc driver to account for some of the rpmb peculiarities.
> +.SH "EXAMPLES"
> +.RE
> +.P
> +.B RPMB examples
> +.RS
> +Program rpmb key using the stdin option:
> +.RS
> +.P
> +$ echo -n AAAABBBBCCCCDDDDEEEEFFFFGGGGHHHH | mmc rpmb write-key /dev/mmcblk0rpmb -
> +.RE
> +.P
> +Read 2 blocks starting address 2 and output the received content to stdout. Verify the received frames using the key (not mandatory):
> +.RS
> +.P
> +$ echo -n AAAABBBBCCCCDDDDEEEEFFFFGGGGHHHH | mmc rpmb read-block /dev/mmcblk0rpmb 0x02 2 -
> +.RE
> +.P
> +Read 2 blocks without verification starting address 2 and output the received content to /tmp/block:
> +.RS
> +.P
> +$mmc rpmb read-block /dev/mmcblk0rpmb 0x02 2 /tmp/block
> +.RE
> +.P
> +Write a string of 'a's to address 2. both the input and key uses stdin interface:
> +.RS
> +.P
> +$ (awk 'BEGIN {while (c++<256) printf "a"}' | echo -n AAAABBBBCCCCDDDDEEEEFFFFGGGGHHHH) | mmc rpmb write-block /dev/mmcblk0rpmb 0x02 - -
> +.RE
> +.P
> +.RE
> +.P
> +.B Field Firmware Update (ffu) examples
> +.RS
> +Do ffu using max-possible chunk size:  If the fluf size < 512k, it will be flushed in a single write sequence.
> +.RS
> +.P
> +$ mmc ffu IO4e0aC2056001801M1100042AE1.fluf /dev/mmcblk0
> +.RE
> +.P
> +Same as above, this time use a 4k chunks:
> +.RS
> +.P
> +$ mmc ffu IO4e0aC2056001801M1100042AE1.fluf /dev/mmcblk0 4096
> +.RE
> +.P
> +.RE
> +.SH AUTHORS
> +.B mmc-utils
> +was written by Chris Ball <cjb@laptop.org> and <chris@printf.net>.
> +.br
> +It is currently maintained by Ulf Hansson <ulf.hansson@linaro.org>.
> +.SH "REPORTING BUGS"
> +Report bugs to the \fBmmc\fR mailing list <linux-mmc@vger.kernel.org>.
> +.SH "SEE ALSO"
> +For further documentation see \fBREADME\fR.
> +.br
> +A short intro - https://docs.kernel.org/driver-api/mmc/mmc-tools.html
> +.br
> +official git tree - https://git.kernel.org/pub/scm/utils/mmc/mmc-utils.git


