Return-Path: <linux-mmc+bounces-2979-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 713F79286BA
	for <lists+linux-mmc@lfdr.de>; Fri,  5 Jul 2024 12:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 249582819E2
	for <lists+linux-mmc@lfdr.de>; Fri,  5 Jul 2024 10:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CC01474BF;
	Fri,  5 Jul 2024 10:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIUEjVMO"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F43A1474A8;
	Fri,  5 Jul 2024 10:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720175119; cv=none; b=K8aF+v6ZQP8HmiopyfdgH9D6S6lrbr9gBiEgxOF1FLHVY+Fw9yukbMEa6sYnN7yp1WWkfWPVk4aeEdzBBJHoU02P1tHxcwje4Y0CQAbrYJ0f3k/IwmfXqO7ea+ddEiX2VOiCPH2AMUMn1oURGslUjTJwGPUrnBMnpUARCxhCZyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720175119; c=relaxed/simple;
	bh=K4DLcIy+remVc6j6HTT0aWOkOY4Q27Twydxxu00jeEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RiuiZclDdSiaxiFCvJZKHzcsHNgjMsGEv/R3BWpsnoHuxGxzJjhh4KT+XiYqAqtqEWWGulPDvaa8G4UmI9bfyVm/Ltub3cfg8fWV1rQ9ivplN7e8D/U3yI2KdtHkPcsuf0qs6eZ+3ZRhT39TqqSlp8j3vcbarIhKHbxCKysg2b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IIUEjVMO; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-80fc4fe7a8eso756277241.1;
        Fri, 05 Jul 2024 03:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720175115; x=1720779915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=feml9E22xbNJafCyImHy1dKLPY5nA2LBdbksWhl3wgY=;
        b=IIUEjVMOfEauM8+mrfImYN+buoIdkwPS2knc4evku2GbZW1w6zYLy4xngWeqvyNaMA
         kFYlmtQuf9+D/GA1E5rUSdXcWgQIVnPGi7BwfVUVfELx2O2I7jOOaZzEPv2C58FJ699p
         td12NTxAW26mu9eVM0jwzZbbtTHABl9fwGQnX8eoB9i7jvhLK9DWDYOBR21QRpjLqiWa
         iLg1tq2AsO9Lf/hil53ByUP5CsnHp1mxrGIjQ6FKQsD+RjDaucM8WoO6h/UeQOnal/EC
         UssthDFxojOh3SGRIDnahWGIf4vdjLgY8LMK49h9ttXBryiFUCRiNmgVcXS3W228JD6o
         7diA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720175115; x=1720779915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=feml9E22xbNJafCyImHy1dKLPY5nA2LBdbksWhl3wgY=;
        b=Z/zBZzCOu9T3wp5DTFyu3UGvkXzuAB8J+Jyfpqr3wB+I7dn5t/pYxyglkRQ8uva/rZ
         QFu+s4dt4A7EUS6eJX6IAbdHhZdMOq1IV4Lt55O2lU6RgpxoTBpOEccP99fvtlb8uF9o
         T4m2OfFtKZHqCvcaegyS0K+k5zHU31iSdzwtMn+i5m7r5/QLrjkTJw6wfzqJvv4wouNO
         RfBlfIAYR/r5E5TxWAJN9pE9OPsL8UKYYzZZOHymNvd/Yn16PY95zp3+8B3N02N6XtBb
         6P/HgqF+9CS3bKb73U5Ye7RhimK1PvqvB5IF47iUbZYGnqTVkFf5JQLEQrOjx+PFzjap
         38fg==
X-Forwarded-Encrypted: i=1; AJvYcCWAp21twiETqxtu8Z+GY/xSpIWWsQroCO7lyRxSJO8xluP7+0G1HR/+EkqdPtFNqCCtmoa7XruK3jq2XOzwrEZWRFnAkKtlI0KcUTUtPdt/gINjPXQJjWzOsX+sS0BrHeK6BKWWrpFX
X-Gm-Message-State: AOJu0YwRTeNtBMwMHFOAn/ds4iioPHsXcOKT0W+y5WEfmRIqpEZEizdF
	m5Dn37CX8dJCQtoUjvsrLW1rD5sp6Gr7zAap/geslDNSBDe2VPN4cqRZ0E+3k73Ksn0RRHxKPk1
	mt4ihFFaKtRogJTq4MRDqP98Al5g=
X-Google-Smtp-Source: AGHT+IG5t3Yj9K0tzssSqw2UZsrrt0IBXbdolpiCxyjWaGoQP/MFRnY7e1LhiI1txoGVdETglioiBw4qRM0Tdg3tCz0=
X-Received: by 2002:a67:ec0d:0:b0:48f:e9f5:2e37 with SMTP id
 ada2fe7eead31-48fef1db0d1mr2499455137.6.1720175114297; Fri, 05 Jul 2024
 03:25:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620104444.5862-1-victorshihgli@gmail.com> <bcd46d4c-fc60-430a-ba9b-4884f4428fea@intel.com>
In-Reply-To: <bcd46d4c-fc60-430a-ba9b-4884f4428fea@intel.com>
From: Victor Shih <victorshihgli@gmail.com>
Date: Fri, 5 Jul 2024 18:25:02 +0800
Message-ID: <CAK00qKAYwFV_Bz8n+KxxsEwRrfo-itZpv2+OyZHRfqU-dBWYAA@mail.gmail.com>
Subject: Re: [PATCH V17 00/22] Add support UHS-II for GL9755 and GL9767
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, benchuanggli@gmail.com, 
	HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw, 
	takahiro.akashi@linaro.org, dlunev@chromium.org, 
	Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 29, 2024 at 1:17=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 20/06/24 13:44, Victor Shih wrote:
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >
> > Summary
> > =3D=3D=3D=3D=3D=3D=3D
> > These patches[1] support UHS-II and fix GL9755 and GL9767
> > UHS-II compatibility.
> >
> > About UHS-II, roughly deal with the following three parts:
> > 1) A UHS-II detection and initialization:
> > - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup
> >   Sequence[2]).
> > - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence
> >   [2]).
> > - In step(9) of Section 3.13.2 in [2], UHS-II initialization is include
> >   Section 3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II
> >   Setting Register Setup Sequence.
> >
> > 2) Send Legacy SD command through SD-TRAN
> > - Encapsulated SD packets are defined in SD-TRAN in order to ensure Leg=
acy
> >   SD compatibility and preserve Legacy SD infrastructures (Section 7.1.=
1
> >   Packet Types and Format Overview[3]).
> > - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-=
II
> >   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2])=
.
> >
> > 3) UHS-II Interrupt
> > - Except for UHS-II error interrupts, most interrupts share the origina=
l
> >   interrupt registers.
> >
> > Patch structure
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > patch#1-#7:  for core
> > patch#8-#20: for sdhci
> > patch#21:    for GL9755
> > patch#22:    for GL9767
> >
> > Changes in v17 (June. 20, 2024)
> > * Rebase on latest mmc/next.
> > * Drop patch#8 of uhs2 patches series v16.
> > * Patch#11: Move the sdhci_uhs2_reset_cmd_data() to the other patch
> >             it was used for the first time.
> > * Patch#12: Export sdhci_uhs2_set_power() function.
> > * Patch#16: Add new parameter to __sdhci_finish_data_common().
> > * Patch#17: Add sdhci_uhs2_reset_cmd_data() and sdhci_uhs2_needs_reset(=
) to
> >             resolve the data error or cmd error.
> > * Patch#21: Rname gl9755_overcurrent_event_enable() to
> >             sdhci_gli_overcurrent_event_enable().
> > * Patch#22: Use mmc_card_uhs2() to simplify the code in the
> >             sdhci_gl9767_reset().
> >             Use mmc_card_uhs2() to simplify the code in the
> >             sdhci_gl9767_set_power().
> >             Add sdhci_gli_overcurrent_event_enable() to
> >             sdhci_gl9767_set_power().
>
> The changes in V17 look fine.
>
> I have no further comments for SDHCI at this stage.
>
> AFAICT because SD-TRAN is used, CMD12 is OK to abort
> data transfers if necessary.
>
> Can you confirm that the current patchset is working
> on your platform?

Hi, Adrian

Yes, please refer to the test data below.

Tests
=3D=3D=3D=3D=3D
Ran 'dd' command to evaluate the performance:
(SanDisk UHS-II card on GL9755 controller)
                             Read    Write
UHS-II disabled (UHS-I): 84.8MB/s 50.0MB/s
UHS-II enabled         :  199MB/s 76.9MB/s

(SanDisk UHS-II card on GL9767 controller)
                             Read    Write
UHS-II disabled (UHS-I): 84.6MB/s 49.6MB/s
UHS-II enabled         :  155MB/s 67.4MB/s

Thanks, Victor Shih

>
> In other respects you probably need to get some feedback
> from Ulf.
>
> >
> > Reference
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [1] https://gitlab.com/VictorShih/linux-uhs2.git
> > [2] SD Host Controller Simplified Specification 4.20
> > [3] UHS-II Simplified Addendum 1.02
> > [4] https://patchwork.kernel.org/project/linux-mmc/cover/20240522110909=
.10060-1-victorshihgli@gmail.com/
> >
> > ----------------- original cover letter from v16 -----------------
> > Summary
> > =3D=3D=3D=3D=3D=3D=3D
> > These patches[1] support UHS-II and fix GL9755 and GL9767
> > UHS-II compatibility.
> >
> > About UHS-II, roughly deal with the following three parts:
> > 1) A UHS-II detection and initialization:
> > - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup
> >   Sequence[2]).
> > - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence
> >   [2]).
> > - In step(9) of Section 3.13.2 in [2], UHS-II initialization is include
> >   Section 3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II
> >   Setting Register Setup Sequence.
> >
> > 2) Send Legacy SD command through SD-TRAN
> > - Encapsulated SD packets are defined in SD-TRAN in order to ensure Leg=
acy
> >   SD compatibility and preserve Legacy SD infrastructures (Section 7.1.=
1
> >   Packet Types and Format Overview[3]).
> > - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-=
II
> >   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2])=
.
> >
> > 3) UHS-II Interrupt
> > - Except for UHS-II error interrupts, most interrupts share the origina=
l
> >   interrupt registers.
> >
> > Patch structure
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > patch#1-#8:  for core
> > patch#9-#21: for sdhci
> > patch#22:    for GL9755
> > patch#23:    for GL9767
> >
> > Changes in v16 (May. 22, 2024)
> > * rebased to the linux-kernel-v6.9.0-rc2 in Ulf Hansson next branch.
> > * according to the comments provided by Adrian Hunter to modify the
> >   patches base on the [V14 00/21] Add support UHS-II for GL9755.
> > * Patch#8: Separate the Error Recovery mechanism from patch#7 to patch#=
8.
> > * Patch#16: Remove irrelevant definition in the sdhci_calc_timeout_uhs2=
().
> >
> > Reference
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [1] https://gitlab.com/VictorShih/linux-uhs2.git
> > [2] SD Host Controller Simplified Specification 4.20
> > [3] UHS-II Simplified Addendum 1.02
> > [4] https://patchwork.kernel.org/project/linux-mmc/cover/20240123062827=
.8525-1-victorshihgli@gmail.com/
> >
> > ----------------- original cover letter from v15 -----------------
> > Summary
> > =3D=3D=3D=3D=3D=3D=3D
> > These patches[1] support UHS-II and fix GL9755 and GL9767
> > UHS-II compatibility.
> >
> > About UHS-II, roughly deal with the following three parts:
> > 1) A UHS-II detection and initialization:
> > - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup
> >   Sequence[2]).
> > - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence
> >   [2]).
> > - In step(9) of Section 3.13.2 in [2], UHS-II initialization is include
> >   Section 3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II
> >   Setting Register Setup Sequence.
> >
> > 2) Send Legacy SD command through SD-TRAN
> > - Encapsulated SD packets are defined in SD-TRAN in order to ensure Leg=
acy
> >   SD compatibility and preserve Legacy SD infrastructures (Section 7.1.=
1
> >   Packet Types and Format Overview[3]).
> > - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-=
II
> >   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2])=
.
> >
> > 3) UHS-II Interrupt
> > - Except for UHS-II error interrupts, most interrupts share the origina=
l
> >   interrupt registers.
> >
> > Patch structure
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > patch#1-#7:  for core
> > patch#8-#20: for sdhci
> > patch#21:    for GL9755
> > patch#22:    for GL9767
> >
> > Changes in v15 (April. 22, 2024)
> > * rebased to the linux-kernel-v6.9.0-rc2 in Ulf Hansson next branch.
> > * according to the comments provided by Adrian Hunter to modify the
> >   patches base on the [V14 00/21] Add support UHS-II for GL9755.
> > * Patch#07: Move struct uhs2_command uhs2_cmd to struct mmc_request and
> >             modify whatever other changers to make it work.
> >             Refer the SD Host Controller Standard Specification
> >             Section 3.10 to add Error Recovery mechanism to recover
> >             the command error.
> > * Patch#11: Refer the SD Host Controller Standard Specification
> >             Section 3.10 to add reset command data mechanism.
> > * Patch#15: Resolve merge conflicts and reduce unnecessary line breaks.
> > * Patch#16: Adjust the parameters used in the __sdhci_uhs2_finish_comma=
nd()
> >             to match changes in the Patch#7.
> > * Patch#21: Adjust gl9755_vendor_init() to the correct function.
> > * Patch#22: Add gl9767 to support uhs2 function.
> >
> > Reference
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [1] https://gitlab.com/VictorShih/linux-uhs2.git
> > [2] SD Host Controller Simplified Specification 4.20
> > [3] UHS-II Simplified Addendum 1.02
> > [4] https://patchwork.kernel.org/project/linux-mmc/cover/20240123062827=
.8525-1-victorshihgli@gmail.com/
> >
> > ----------------- original cover letter from v14 -----------------
> > Summary
> > =3D=3D=3D=3D=3D=3D=3D
> > These patches[1] support UHS-II and fix GL9755 UHS-II compatibility.
> >
> > About UHS-II, roughly deal with the following three parts:
> > 1) A UHS-II detection and initialization:
> > - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup
> >   Sequence[2]).
> > - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence
> >   [2]).
> > - In step(9) of Section 3.13.2 in [2], UHS-II initialization is include
> >   Section 3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II
> >   Setting Register Setup Sequence.
> >
> > 2) Send Legacy SD command through SD-TRAN
> > - Encapsulated SD packets are defined in SD-TRAN in order to ensure Leg=
acy
> >   SD compatibility and preserve Legacy SD infrastructures (Section 7.1.=
1
> >   Packet Types and Format Overview[3]).
> > - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-=
II
> >   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2])=
.
> >
> > 3) UHS-II Interrupt
> > - Except for UHS-II error interrupts, most interrupts share the origina=
l
> >   interrupt registers.
> >
> > Patch structure
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > patch#1-#7:  for core
> > patch#8-#20: for sdhci
> > patch#21:    for GL9755
> >
> > Changes in v14 (January. 23, 2024)
> > * rebased to the linux-kernel-v6.7.0-rc4 in Ulf Hansson next branch.
> > * according to the comments provided by Adrian Hunter to modify the
> >   patches base on the [V13 00/21] Add support UHS-II for GL9755.
> > * Patch#03: Move mmc_card_uhs2() to include/linux/mmc/host.h, so that
> >             mmc_card_uhs2() can be available for host drivers.
> > * Patch#10: Use mmc_card_uhs2() to stead sdhci_uhs2_mode() in the
> >             sdhci_uhs2_dump_regs().
> > * Patch#11: Since mmc_card_uhs2() is the same as sdhci_uhs2_mode(), so
> >             drop sdhci_uhs2_mode() and use mmc_card_uhs2() instead of
> >             sdhci_uhs2_mode().
> > * Patch#13: Use mmc_card_uhs2() to stead sdhci_uhs2_mode() in the
> >             sdhci_uhs2_set_timeout().
> > * Patch#14: Use mmc_card_uhs2() to stead sdhci_uhs2_mode() in the
> >             sdhci_uhs2_set_ios().
> > * Patch#16: Use mmc_card_uhs2() to stead sdhci_uhs2_mode() in the
> >             sdhci_uhs2_request().
> > * Patch#17: Use mmc_card_uhs2() to stead sdhci_uhs2_mode() in the
> >             sdhci_uhs2_complete_work(), sdhci_uhs2_irq() and
> >             sdhci_uhs2_thread_irq().
> > * Patch#18: Use mmc_card_uhs2() to stead sdhci_uhs2_mode() in the
> >             __sdhci_uhs2_remove_host().
> >
> > Reference
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [1] https://gitlab.com/VictorShih/linux-uhs2.git
> > [2] SD Host Controller Simplified Specification 4.20
> > [3] UHS-II Simplified Addendum 1.02
> > [4] https://patchwork.kernel.org/project/linux-mmc/cover/20230915094351=
.11120-1-victorshihgli@gmail.com/
> >
> > ----------------- original cover letter from v13 -----------------
> > Summary
> > =3D=3D=3D=3D=3D=3D=3D
> > These patches[1] support UHS-II and fix GL9755 UHS-II compatibility.
> >
> > About UHS-II, roughly deal with the following three parts:
> > 1) A UHS-II detection and initialization:
> > - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup
> >   Sequence[2]).
> > - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence
> >   [2]).
> > - In step(9) of Section 3.13.2 in [2], UHS-II initialization is include
> >   Section 3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II
> >   Setting Register Setup Sequence.
> >
> > 2) Send Legacy SD command through SD-TRAN
> > - Encapsulated SD packets are defined in SD-TRAN in order to ensure Leg=
acy
> >   SD compatibility and preserve Legacy SD infrastructures (Section 7.1.=
1
> >   Packet Types and Format Overview[3]).
> > - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-=
II
> >   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2])=
.
> >
> > 3) UHS-II Interrupt
> > - Except for UHS-II error interrupts, most interrupts share the origina=
l
> >   interrupt registers.
> >
> > Patch structure
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > patch#1-#7:  for core
> > patch#8-#20: for sdhci
> > patch#21:    for GL9755
> >
> > Changes in v13 (November. 17, 2023)
> > * rebased to the linux-kernel-v6.7.0-rc1 in Ulf Hansson next branch.
> > * according to the comments provided by Adrian Hunter to modify the
> >   patches base on the [V12 00/23] Add support UHS-II for GL9755.
> > * according to the comments provided by Ulf Hansson to modify the
> >   patches base on the [V12 00/23] Add support UHS-II for GL9755.
> > * Add new patch#6 to re-factoring the code.
> > * Patch#7: Separate __mmc_go_idle() into one patch for re-factorring th=
e code.
> >            Move mmc_decode_scr declaration to sd.h.
> >            Ues uhs2_sd_tran to stead MMC_UHS2_SD_TRAN.
> >            Drop unnecessary comment.
> > * Patch#11: Use ios timing to stead MMC_UHS2_SUPPORT for indicate the U=
HS2 mode.
> > * Patch#12: Drop use vmmc2.
> >             Modify comment message.
> > * Patch#13: Modify comment message.
> > * Patch#14: Add judgment condition for power mode in the __sdhci_uhs2_s=
et_ios().
> >             Modify comment message.
> > * Patch#15: Merge Patch#15, Patch#16 and Patch#17 of v12 version into P=
atch#15 in v13 version.
> >             Use definitions to simplify code.
> >             Modify comment message.
> > * Patch#16: Re-order function to avoid declaration.
> >             Remove unnecessary function.
> > * Patch#17: Re-order function to avoid declaration.
> >             Remove unnecessary definitions.
> > * Patch#18: Re-order function to avoid declaration.
> >             Use vqmmc2 to stead vmmc2.
> > * Patch#21: Ues uhs2_sd_tran to stead MMC_UHS2_SD_TRAN.
> >
> > Reference
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [1] https://gitlab.com/VictorShih/linux-uhs2.git
> > [2] SD Host Controller Simplified Specification 4.20
> > [3] UHS-II Simplified Addendum 1.02
> > [4] https://patchwork.kernel.org/project/linux-mmc/cover/20230915094351=
.11120-1-victorshihgli@gmail.com/
> >
> > ----------------- original cover letter from v12 -----------------
> > Summary
> > =3D=3D=3D=3D=3D=3D=3D
> > These patches[1] support UHS-II and fix GL9755 UHS-II compatibility.
> >
> > About UHS-II, roughly deal with the following three parts:
> > 1) A UHS-II detection and initialization:
> > - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup
> >   Sequence[2]).
> > - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence
> >   [2]).
> > - In step(9) of Section 3.13.2 in [2], UHS-II initialization is include
> >   Section 3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II
> >   Setting Register Setup Sequence.
> >
> > 2) Send Legacy SD command through SD-TRAN
> > - Encapsulated SD packets are defined in SD-TRAN in order to ensure Leg=
acy
> >   SD compatibility and preserve Legacy SD infrastructures (Section 7.1.=
1
> >   Packet Types and Format Overview[3]).
> > - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-=
II
> >   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2])=
.
> >
> > 3) UHS-II Interrupt
> > - Except for UHS-II error interrupts, most interrupts share the origina=
l
> >   interrupt registers.
> >
> > Patch structure
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > patch#1-#6:  for core
> > patch#7-#22: for sdhci
> > patch#23:    for GL9755
> >
> > Changes in v12 (September. 15, 2023)
> > * rebased to the linux-kernel-v6.6.0-rc1 in Ulf Hansson next branch.
> > * according to the comments provided by Adrian Hunter to modify the
> >   patches base on the [V11 00/23] Add support UHS-II for GL9755.
> > * according to the comments provided by Ulf Hansson to modify the
> >   patches base on the [V11 00/23] Add support UHS-II for GL9755.
> > * Patch#5: Remove unused max_current_180_vdd2.
> > * Patch#6: Use mmc_op_multi() to check DCMD which supports multi
> >            read/write in mmc_uhs2_prepare_cmd().
> >
> > Reference
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [1] https://gitlab.com/VictorShih/linux-uhs2.git
> > [2] SD Host Controller Simplified Specification 4.20
> > [3] UHS-II Simplified Addendum 1.02
> > [4] https://patchwork.kernel.org/project/linux-mmc/cover/20230908095330=
.12075-1-victorshihgli@gmail.com/
> >
> > ----------------- original cover letter from v11 -----------------
> > Summary
> > =3D=3D=3D=3D=3D=3D=3D
> > These patches[1] support UHS-II and fix GL9755 UHS-II compatibility.
> >
> > About UHS-II, roughly deal with the following three parts:
> > 1) A UHS-II detection and initialization:
> > - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup
> >   Sequence[2]).
> > - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence
> >   [2]).
> > - In step(9) of Section 3.13.2 in [2], UHS-II initialization is include
> >   Section 3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II
> >   Setting Register Setup Sequence.
> >
> > 2) Send Legacy SD command through SD-TRAN
> > - Encapsulated SD packets are defined in SD-TRAN in order to ensure Leg=
acy
> >   SD compatibility and preserve Legacy SD infrastructures (Section 7.1.=
1
> >   Packet Types and Format Overview[3]).
> > - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-=
II
> >   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2])=
.
> >
> > 3) UHS-II Interrupt
> > - Except for UHS-II error interrupts, most interrupts share the origina=
l
> >   interrupt registers.
> >
> > Patch structure
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > patch#1-#6:  for core
> > patch#7-#22: for sdhci
> > patch#23:    for GL9755
> >
> > Changes in v11 (September. 08, 2023)
> > * rebased to the linux-kernel-v6.5.0-rc5 in Ulf Hansson next branch.
> > * according to the comments provided by Adrian Hunter to modify the
> >   patches base on the [V10 00/23] Add support UHS-II for GL9755.
> > * Patch#18: Drop the check mmc_card_uhs2_hd_mode(host->mmc)
> >             in sdhci_uhs2_set_transfer_mode().
> > * Patch#20: Remove unused ocr_avail_uhs2.
> >
> > Reference
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [1] https://gitlab.com/VictorShih/linux-uhs2.git
> > [2] SD Host Controller Simplified Specification 4.20
> > [3] UHS-II Simplified Addendum 1.02
> > [4] https://patchwork.kernel.org/project/linux-mmc/cover/20230721101349=
.12387-1-victorshihgli@gmail.com/
> >
> > ----------------- original cover letter from v10 -----------------
> > Summary
> > =3D=3D=3D=3D=3D=3D=3D
> > These patches[1] support UHS-II and fix GL9755 UHS-II compatibility.
> >
> > About UHS-II, roughly deal with the following three parts:
> > 1) A UHS-II detection and initialization:
> > - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup
> >   Sequence[2]).
> > - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence
> >   [2]).
> > - In step(9) of Section 3.13.2 in [2], UHS-II initialization is include
> >   Section 3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II
> >   Setting Register Setup Sequence.
> >
> > 2) Send Legacy SD command through SD-TRAN
> > - Encapsulated SD packets are defined in SD-TRAN in order to ensure Leg=
acy
> >   SD compatibility and preserve Legacy SD infrastructures (Section 7.1.=
1
> >   Packet Types and Format Overview[3]).
> > - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-=
II
> >   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2])=
.
> >
> > 3) UHS-II Interrupt
> > - Except for UHS-II error interrupts, most interrupts share the origina=
l
> >   interrupt registers.
> >
> > Patch structure
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > patch#1-#6:  for core
> > patch#7-#22: for sdhci
> > patch#23:    for GL9755
> >
> > Changes in v10 (August. 18, 2023)
> > * rebased to the linux-kernel-v6.5.0-rc5 in Ulf Hansson next branch.
> > * according to the comments provided by Ulf Hansson to modify the
> >   patches base on the [V9 00/23] Add support UHS-II for GL9755.
> > * Patch#2: Drop unnecessary definitions and code.
> > * Patch#3: Modify the commit message.
> > * Patch#4: Modify the commit message.
> > * Patch#5: Drop unnecessary definitions.
> > * Patch#6: Move some definitions of PatchV9[02/23] to PatchV10[06/23].
> >            Move some definitions of PatchV9[05/23] to PatchV10[06/23].
> >            Drop do_multi in the mmc_blk_rw_rq_prep().
> >            Use tmode_half_duplex to instead of uhs2_tmode0_flag.
> >            Move entire control of the tmode into mmc_uhs2_prepare_cmd()=
.
> > * Patch#11: Move some definitions of PatchV9[05/23] to PatchV10[11/23].
> > * Patch#18: Use tmode_half_duplex to instead of uhs2_tmode0_flag
> >             in sdhci_uhs2_set_transfer_mode().
> > * Patch#20: Move some definitions of PatchV9[05/23] to PatchV10[20/23].
> >
> > Reference
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [1] https://gitlab.com/VictorShih/linux-uhs2.git
> > [2] SD Host Controller Simplified Specification 4.20
> > [3] UHS-II Simplified Addendum 1.02
> > [4] https://patchwork.kernel.org/project/linux-mmc/cover/20230721101349=
.12387-1-victorshihgli@gmail.com/
> >
> > ----------------- original cover letter from v9 -----------------
> > Summary
> > =3D=3D=3D=3D=3D=3D=3D
> > These patches[1] support UHS-II and fix GL9755 UHS-II compatibility.
> >
> > About UHS-II, roughly deal with the following three parts:
> > 1) A UHS-II detection and initialization:
> > - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup
> >   Sequence[2]).
> > - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence
> >   [2]).
> > - In step(9) of Section 3.13.2 in [2], UHS-II initialization is include
> >   Section 3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II
> >   Setting Register Setup Sequence.
> >
> > 2) Send Legacy SD command through SD-TRAN
> > - Encapsulated SD packets are defined in SD-TRAN in order to ensure Leg=
acy
> >   SD compatibility and preserve Legacy SD infrastructures (Section 7.1.=
1
> >   Packet Types and Format Overview[3]).
> > - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-=
II
> >   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2])=
.
> >
> > 3) UHS-II Interrupt
> > - Except for UHS-II error interrupts, most interrupts share the origina=
l
> >   interrupt registers.
> >
> > Patch structure
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > patch#1-#6:  for core
> > patch#7-#22: for sdhci
> > patch#23:    for GL9755
> >
> > Changes in v9 (July. 21, 2023)
> > * rebased to the linux-kernel-v6.5.0-rc1 in Ulf Hansson next branch.
> > * according to the comments provided by Adrian Hunter to modify the
> >   patches base on the [V8 00/23] Add support UHS-II for GL9755.
> > * Patch#2: move sd_uhs2_operation definition of PatchV8[05/23]
> >            to PatchV9[02/23] for avoid compilation errors.
> >            move uhs2_control definition of PatchV8[05/23]
> >            to PatchV9[02/23] for avoid compilation errors.
> >            move mmc_host flags definition of PatchV8[05/23]
> >            to PatchV9[02/23] for avoid compilation errors.
> >            move mmc_host flags MMC_UHS2_SUPPORT definition of
> >            PatchV8[05/23] to PatchV9[02/23] for avoid compilation error=
s.
> >            move mmc_host flags MMC_UHS2_SD_TRAN definition of
> >            PatchV8[05/23] to PatchV9[02/23] for avoid compilation error=
s.
> > * Patch#7: Modify the commit message.
> > * Patch#8: Modify the commit message.
> > * Patch#11: Modify annotations in sdhci_get_vdd_value().
> > * Patch#14: Simplity the turning_on_clk in sdhci_set_ios().
> > * Patch#18: Modify the annotations in __sdhci_uhs2_send_command().
> > * Patch#19: Cancel export state of sdhci_set_mrq_done() function.
> > * Patch#23: Rename gl9755_pre_detect_init() to sdhci_gli_pre_detect_ini=
t().
> >             Rename gl9755_uhs2_reset_sd_tran() to
> >             sdhci_gli_uhs2_reset_sd_tran().
> >
> > Reference
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [1] https://gitlab.com/VictorShih/linux-uhs2.git
> > [2] SD Host Controller Simplified Specification 4.20
> > [3] UHS-II Simplified Addendum 1.02
> > [4] https://patchwork.kernel.org/project/linux-mmc/cover/20230621100151=
.6329-1-victorshihgli@gmail.com/
> >
> > ----------------- original cover letter from v8 -----------------
> > Summary
> > =3D=3D=3D=3D=3D=3D=3D
> > These patches[1] support UHS-II and fix GL9755 UHS-II compatibility.
> >
> > About UHS-II, roughly deal with the following three parts:
> > 1) A UHS-II detection and initialization:
> > - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup
> >   Sequence[2]).
> > - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence
> >   [2]).
> > - In step(9) of Section 3.13.2 in [2], UHS-II initialization is include
> >   Section 3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II
> >   Setting Register Setup Sequence.
> >
> > 2) Send Legacy SD command through SD-TRAN
> > - Encapsulated SD packets are defined in SD-TRAN in order to ensure Leg=
acy
> >   SD compatibility and preserve Legacy SD infrastructures (Section 7.1.=
1
> >   Packet Types and Format Overview[3]).
> > - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-=
II
> >   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2])=
.
> >
> > 3) UHS-II Interrupt
> > - Except for UHS-II error interrupts, most interrupts share the origina=
l
> >   interrupt registers.
> >
> > Patch structure
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > patch#1-#6:  for core
> > patch#7-#22: for sdhci
> > patch#23:    for GL9755
> >
> > Changes in v8 (June. 21, 2023)
> > * rebased to the linux-kernel-v6.4.0-rc6 in Ulf Hansson next branch.
> > * fix most of checkpatch warnings/errors.
> > * according to the comments provided by Adrian Hunter to modify the
> >   patches base on the [V7 00/23] Add support UHS-II for GL9755.
> > * Patch#6: Add MMC_UHS2_SUPPORT to be cleared in sd_uhs2_detect().
> >            Modify return value in sd_uhs2_attach().
> > * Patch#7: Use tabs instead of spaces.
> > * Patch#8: Modify MODULE_LICENSE from "GPL v2" to "GPL".
> > * Patch#10: Adjust the position of matching brackets.
> > * Patch#11: Adjust the position of matching brackets.
> >             Add the initial value of the pwr in sdhci_uhs2_set_power().
> > * Patch#13: Initialization be combined with declaration and realigned
> >             in sdhci_calc_timeout_uhs2().
> >             Forward declare struct mmc_command in sdhci_uhs2.h.
> > * Patch#14: Add the judgment formula for MMC_TIMING_SPEED_A_HD,
> >             MMC_TIMING_SPEED_B and MMC_TIMING_SPEED_B_HD in
> >             __sdhci_uhs2_set_ios().
> >             Add the switch case for MMC_TIMING_SPEED_A_HD,
> >             MMC_TIMING_SPEED_B and MMC_TIMING_SPEED_B_HD in
> >             sdhci_get_preset_value().
> >             mmc_opt_regulator_set_ocr() to instead of
> >             mmc_regulator_set_ocr() in sdhci_uhs2_set_ios().
> > * Patch#15: usleep_range() to instead of udelay() in
> >             sdhci_uhs2_interface_detect().
> >             read_poll_timeout() to instead of read_poll_timeout_atomic(=
)
> >             in sdhci_uhs2_interface_detect().
> >             Modify return value in sdhci_uhs2_do_detect_init().
> > * Patch#16: Remove unnecessary include file.
> >             read_poll_timeout() to instead of read_poll_timeout_atomic(=
)
> >             in sdhci_uhs2_enable_clk().
> >             Put the comment on the end and put the lines in descending
> >             line length in sdhci_uhs2_enable_clk().
> >             Modify return value in sdhci_uhs2_enable_clk().
> > * Patch#17: Reorder the definitions and lose the parentheses in
> >             sdhci_uhs2_set_config().
> >             read_poll_timeout() to instead of read_poll_timeout_atomic(=
)
> >             in sdhci_uhs2_check_dormant().
> > * Patch#18: Adjust the position of matching brackets in
> >             sdhci_uhs2_send_command_retry().
> >             Modify CameCase definition in __sdhci_uhs2_finish_command()=
.
> >             Modify error message in __sdhci_uhs2_finish_command().
> >             sdhci_uhs2_send_command_retry() to instead of
> >             sdhci_uhs2_send_command() in sdhci_uhs2_request().
> >             Use sdhci_uhs2_mode() to simplify code in
> >             sdhci_uhs2_request_atomic().
> >             Add forward declaration for sdhci_send_command().
> > * Patch#19: Forward declare struct mmc_request in sdhci_uhs2.h.
> >             Remove forward declaration of sdhci_send_command().
> >             Use mmc_dev() to simplify code in sdhci_request_done_dma().
> > * Patch#20: Change return type to void for __sdhci_uhs2_add_host_v4().
> >             Remove unused variables in __sdhci_uhs2_add_host_v4().
> > * Patch#22: Add config select MMC_SDHCI_UHS2 in Kconfig.
> > * Patch#23: Use sdhci_get_vdd_value() to simplify code in
> >             gl9755_set_power().
> >             Use read_poll_timeout_atomic() to simplify code in
> >             sdhci_wait_clock_stable().
> >             Use read_poll_timeout_atomic() to simplify code in
> >             sdhci_gl9755_reset().
> >
> > Reference
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [1] https://gitlab.com/VictorShih/linux-uhs2.git
> > [2] SD Host Controller Simplified Specification 4.20
> > [3] UHS-II Simplified Addendum 1.02
> > [4] https://patchwork.kernel.org/project/linux-mmc/cover/20230331105546=
.13607-1-victor.shih@genesyslogic.com.tw/
> >
> > ----------------- original cover letter from v7 -----------------
> > Summary
> > =3D=3D=3D=3D=3D=3D=3D
> > These patches[1] support UHS-II and fix GL9755 UHS-II compatibility.
> >
> > About UHS-II, roughly deal with the following three parts:
> > 1) A UHS-II detection and initialization:
> > - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup Se=
quence
> >   [2]).
> > - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence=
[2]).
> > - In step(9) of Section 3.13.2 in [2], UHS-II initialization is include=
 Section
> >   3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II Setting R=
egister
> >   Setup Sequence.
> >
> > 2) Send Legacy SD command through SD-TRAN
> > - Encapsulated SD packets are defined in SD-TRAN in order to ensure Leg=
acy SD
> >   compatibility and preserve Legacy SD infrastructures (Section 7.1.1 P=
acket
> >   Types and Format Overview[3]).
> > - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-=
II
> >   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2])=
.
> >
> > 3) UHS-II Interrupt
> > - Except for UHS-II error interrupts, most interrupts share the origina=
l
> >   interrupt registers.
> >
> > Patch structure
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > patch#1-#6:  for core
> > patch#7-#22: for sdhci
> > patch#23:    for GL9755
> >
> > Changes in v7 (Mar. 31, 2023)
> > * rebased to the linux-kernel-v6.3.0-rc3 in Ulf Hansson next branch.
> > * according to the guidance and overall architecture provided
> >   by Ulf Hansson, Ben Chuang and Jason Lai to implement the
> >   UHS-2 Core function based on the patches of the [V4,0/6]
> >   Preparations to support SD UHS-II cards[5].
> > * according to the guidance and comments provided by
> >   Adrian Hunter, Ben Chuang and AKASHI Takahiro to implement
> >   the UHS-2 Host function based on the patches of the
> >   [RFC,v3.1,00/27] Add support UHS-II for GL9755[4].
> > * implement the necessary function to let the UHS-2 Core/Host
> >   work properly.
> > * fix most of checkpatch warnings/errors.
> > * according to the guidance and comments provided by
> >   Adrian Hunter, Ben Chuang to implement the UHS-2
> >   Host function based on the patches of the
> >   [V5,00/26] Add support UHS-II for GL9755[6].
> > * according to the guidance and comments provided by
> >   Ulf Hanssion, Adrian Hunter, Ben Chuang to implement the UHS-2
> >   Host function based on the patches of the
> >   [V6,00/24] Add support UHS-II for GL9755[7].
> > * The uhs2_post_attach_sd() function is no longer needed so drop
> >   the V6 version of the Patch#22.
> > * Modifies the usage of the flags used by the sdhci host for
> >   MMC_UHS2_INITIALIZED.
> > * Patch#1: Drop unnecessary bracket.
> > * Patch#2: Drop sd_uhs2_set_ios function.
> >            Used ->uhs2_control() callback for uhs2_set_ios
> >            in sd_uhs2_power_up().
> >            Used ->uhs2_control() callback for uhs2_set_ios
> >            in sd_uhs2_power_off().
> >            Drop MMC_TIMING_SD_UHS2 in favor of MMC_TIMING_UHS2_SPEED_A.
> >            Modify sd_uhs2_legacy_init to avoid the
> >            sd_uhs2_reinit cycle issue.
> > * Patch#5: Drop unnecessary definitions.
> > * Patch#6: Drop unnecessary function.
> >            Drop uhs2_state in favor of ios->timing.
> > * Patch#7: Reorder values and positions of definitions.
> > * Patch#9: Used sdhci_uhs2_mode function to simplify.
> > * Patch#11: Drop pwr variable in sdhci_uhs2_set_power function.
> > * Patch#14: Modify some descriptions.
> >             Drop unnecessary function.
> > * Patch#15: Drop using uhs2_reset ops and use sdhci_uhs2_reset function
> >             in the sdhci_do_detect_init function.
> > * Patch#17: Drop unnecessary function.
> > * Patch#18: Drop unnecessary whitespace changes.
> >             Cancel the export state of some functions.
> > * Patch#19: Drop unnecessary function.
> >             Used sdhci_uhs2_mode function to simplify.
> >             Modify some descriptions.
> >             Cancel the export state of some functions.
> > * Patch#20: Drop using __sdhci_uhs2_host function and use
> >             __sdhci_add_host function in sdhci_uhs2_add_host function.
> >             Cancel the export state of some functions.
> > * Patch#23: Drop using uhs2_post_attach_sd function.
> >
> > Reference
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [1] https://gitlab.com/ben.chuang/linux-uhs2-gl9755.git
> > [2] SD Host Controller Simplified Specification 4.20
> > [3] UHS-II Simplified Addendum 1.02
> > [4] https://patchwork.kernel.org/project/linux-mmc/cover/20201106022726=
.19831-1-takahiro.akashi@linaro.org/
> > [5] https://patchwork.kernel.org/project/linux-mmc/cover/20220418115833=
.10738-1-jasonlai.genesyslogic@gmail.com/
> > [6] https://patchwork.kernel.org/project/linux-mmc/cover/20221019110647=
.11076-1-victor.shih@genesyslogic.com.tw/
> > [7] https://patchwork.kernel.org/project/linux-mmc/cover/20221213090047=
.3805-1-victor.shih@genesyslogic.com.tw/
> >
> > ----------------- original cover letter from v6 -----------------
> > Summary
> > =3D=3D=3D=3D=3D=3D=3D
> > These patches[1] support UHS-II and fix GL9755 UHS-II compatibility.
> >
> > About UHS-II, roughly deal with the following three parts:
> > 1) A UHS-II detection and initialization:
> > - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup Se=
quence
> >   [2]).
> > - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence=
[2]).
> > - In step(9) of Section 3.13.2 in [2], UHS-II initialization is include=
 Section
> >   3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II Setting R=
egister
> >   Setup Sequence.
> >
> > 2) Send Legacy SD command through SD-TRAN
> > - Encapsulated SD packets are defined in SD-TRAN in order to ensure Leg=
acy SD
> >   compatibility and preserve Legacy SD infrastructures (Section 7.1.1 P=
acket
> >   Types and Format Overview[3]).
> > - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-=
II
> >   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2])=
.
> >
> > 3) UHS-II Interrupt
> > - Except for UHS-II error interrupts, most interrupts share the origina=
l
> >   interrupt registers.
> >
> > Patch structure
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > patch#1-#6:  for core
> > patch#7-#23: for sdhci
> > patch#24:    for GL9755
> >
> > Changes in v6 (Dec. 12, 2022)
> > * rebased to the linux-kernel-v6.1.0-rc8 in Ulf Hansson next branch.
> > * according to the guidance and overall architecture provided
> >   by Ulf Hansson, Ben Chuang and Jason Lai to implement the
> >   UHS-2 Core function based on the patches of the [V4,0/6]
> >   Preparations to support SD UHS-II cards[5].
> > * according to the guidance and comments provided by
> >   Adrian Hunter, Ben Chuang and AKASHI Takahiro to implement
> >   the UHS-2 Host function based on the patches of the
> >   [RFC,v3.1,00/27] Add support UHS-II for GL9755[4].
> > * implement the necessary function to let the UHS-2 Core/Host
> >   work properly.
> > * fix most of checkpatch warnings/errors.
> > * according to the guidance and comments provided by
> >   Adrian Hunter, Ben Chuang to implement the UHS-2
> >   Host function based on the patches of the
> >   [V5,00/26] Add support UHS-II for GL9755[6].
> > * The uhs2_post_attach_sd() has implemented in Patch#6 and
> >   Patch#17 so drop the V5 version of the Patch#23.
> > * Modifies the usage of the flags used by the sdhci host for
> >   MMC_UHS2_INITIALIZED.
> > * Patch#5: Drop unused definitions and functions.
> > * Patch#7: Rename definitions.
> >            Use BIT() GENMASK() in some cases.
> > * Patch#8: Merge V5 version of Patch[7] and Patch[9] into
> >            V6 version of Patch[8].
> > * Patch#9: Drop unnecessary function.
> >            Rename used definitions.
> > * Patch#10: Drop unnecessary function and simplify some code.
> > * Patch#11: Drop unnecessary function.
> >             Add new mmc_opt_regulator_set_ocr function.
> > * Patch#13: Drop unnecessary function.
> >             Use GENMASK() and FIELD_PREP() in some cases.
> > * Patch#14: Drop unnecessary function.
> >             Modify return value in some function.
> >             Use GENMASK() and FIELD_PREP() in some cases.
> > * Patch#15: Drop unnecessary function.
> >             Rename used definitions.
> >             Use GENMASK() and FIELD_GET() in some cases.
> >             Wrap at 100 columns in some functions.
> > * Patch#16: Drop unnecessary function.
> > * Patch#17: Drop unnecessary function.
> >             Drop the unnecessary parameter when call the DBG()
> >             function.
> >             Rename used definitions.
> >             Cancel the export state of some functions.
> >             Use GENMASK() and FIELD_PREP() in some cases.
> > * Patch#18: Drop unnecessary function.
> >             Add uhs2_dev_cmd function to simplify some functions.
> >             Rename used definitions.
> >             Cancel the export state of some functions.
> >             Use GENMASK() and FIELD_PREP() in some cases.
> > * Patch#19: Drop unnecessary function.
> >             Add sdhci_uhs2_mode() in some functions.
> >             Rename used definitions.
> >             Cancel the export state of some functions.
> > * Patch#20: Add new complete_work_fn/thread_irq_fn variables in
> >             struct sdhci_host.
> >             Use complete_work_fn/thread_irq_fn variables in
> >             sdhci_alloc_host()/sdhci_uhs2_add_host().
> >             Rename used definitions.
> > * Patch[24]: Rename used definitions.
> >
> > Reference
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [1] https://gitlab.com/ben.chuang/linux-uhs2-gl9755.git
> > [2] SD Host Controller Simplified Specification 4.20
> > [3] UHS-II Simplified Addendum 1.02
> > [4] https://patchwork.kernel.org/project/linux-mmc/cover/20201106022726=
.19831-1-takahiro.akashi@linaro.org/
> > [5] https://patchwork.kernel.org/project/linux-mmc/cover/20220418115833=
.10738-1-jasonlai.genesyslogic@gmail.com/
> > [6] https://patchwork.kernel.org/project/linux-mmc/cover/20221019110647=
.11076-1-victor.shih@genesyslogic.com.tw/
> >
> > ----------------- original cover letter from v5 -----------------
> > Summary
> > =3D=3D=3D=3D=3D=3D=3D
> > These patches[1] support UHS-II and fix GL9755 UHS-II compatibility.
> >
> > About UHS-II, roughly deal with the following three parts:
> > 1) A UHS-II detection and initialization:
> > - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup Se=
quence
> >   [2]).
> > - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence=
[2]).
> > - In step(9) of Section 3.13.2 in [2], UHS-II initialization is include=
 Section
> >   3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II Setting R=
egister
> >   Setup Sequence.
> >
> > 2) Send Legacy SD command through SD-TRAN
> > - Encapsulated SD packets are defined in SD-TRAN in order to ensure Leg=
acy SD
> >   compatibility and preserve Legacy SD infrastructures (Section 7.1.1 P=
acket
> >   Types and Format Overview[3]).
> > - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-=
II
> >   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2])=
.
> >
> > 3) UHS-II Interrupt
> > - Except for UHS-II error interrupts, most interrupts share the origina=
l
> >   interrupt registers.
> >
> > Patch structure
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > patch#1-#6:  for core
> > patch#7-#25: for sdhci
> > patch#26:    for GL9755
> >
> > Changes in v5 (Oct. 19, 2022)
> > * rebased to the linux-kernel-v6.1-rc1 in Ulf Hansson next branch.
> > * according to the guidance and overall architecture provided
> >   by Ulf Hansson, Ben Chuang and Jason Lai to implement the
> >   UHS-2 Core function based on the patches of the [V4,0/6]
> >   Preparations to support SD UHS-II cards[5].
> > * according to the guidance and comments provided by
> >   Adrian Hunter, Ben Chuang and AKASHI Takahiro to implement
> >   the UHS-2 Host function based on the patches of the
> >   [RFC,v3.1,00/27] Add support UHS-II for GL9755[4].
> > * implement the necessary function to let the UHS-2 Core/Host
> >   work properly.
> > * fix most of checkpatch warnings/errors
> >
> > Reference
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [1] https://gitlab.com/ben.chuang/linux-uhs2-gl9755.git
> > [2] SD Host Controller Simplified Specification 4.20
> > [3] UHS-II Simplified Addendum 1.02
> > [4] https://patchwork.kernel.org/project/linux-mmc/cover/20201106022726=
.19831-1-takahiro.akashi@linaro.org/
> > [5] https://patchwork.kernel.org/project/linux-mmc/cover/20220418115833=
.10738-1-jasonlai.genesyslogic@gmail.com/
> >
> > ----------------- original cover letter from v3.1 -----------------
> > This is an interim snapshot of our next version, v4, for enabling
> > UHS-II on MMC/SD.
> >
> > It is focused on 'sdhci' side to address Adrian's comments regarding
> > "modularising" sdhci-uhs2.c.
> > The whole aim of this version is to get early feedback from Adrian (and
> > others) on this issue. Without any consensus about the code structure,
> > it would make little sense to go further ahead on sdhci side.
> > (Actually, Adrian has made no comments other than "modularising" so far=
.)
> >
> > I heavily reworked/refactored sdhci-uhs2.c and re-organised the patch
> > set to meet what I believe Adrian expects; no UHS-II related code in
> > Legacy (UHS-I) code or sdhci.c.
> >
> > Nevertheless, almost of all changes I made are trivial and straightforw=
ard
> > in this direction, and I believe that there is no logic changed since v=
3
> > except sdhci_uhs2_irq(), as ops->irq hook, where we must deal with UHS-=
II
> > command sequences in addition to UHS-II errors. So I added extra handli=
ngs.
> >
> > I admit that there is plenty of room for improvements (for example,
> > handling host->flags), but again the focal point here is how sdhci-uhs2=
.c
> > should be built as a module.
> >
> > Please review this series (particularly Patch#8-#26 and #27) from this
> > viewpoint in the first place.
> > (Ben is working on 'host' side but there is no change on 'host' side
> > in this submission except a minor tweak.)
> >
> > Thanks,
> > -Takahiro Akashi
> >
> > ------ original cover letter from v3 ------
> > Summary
> > =3D=3D=3D=3D=3D=3D=3D
> > These patches[1] support UHS-II and fix GL9755 UHS-II compatibility.
> >
> > About UHS-II, roughly deal with the following three parts:
> > 1) A UHS-II detection and initialization:
> > - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup Se=
quence
> >   [2]).
> > - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence=
[2]).
> > - In step(9) of Section 3.13.2 in [2], UHS-II initialization is include=
 Section
> >   3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II Setting R=
egister
> >   Setup Sequence.
> >
> > 2) Send Legacy SD command through SD-TRAN
> > - Encapsulated SD packets are defined in SD-TRAN in order to ensure Leg=
acy SD
> >   compatibility and preserve Legacy SD infrastructures (Section 7.1.1 P=
acket
> >   Types and Format Overview[3]).
> > - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-=
II
> >   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2])=
.
> >
> > 3) UHS-II Interrupt
> > - Except for UHS-II error interrupts, most interrupts share the origina=
l
> >   interrupt registers.
> >
> > Patch structure
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > patch#1-#7: for core
> > patch#8-#17: for sdhci
> > patch#18-#21: for GL9755
> >
> > Tests
> > =3D=3D=3D=3D=3D
> > Ran 'dd' command to evaluate the performance:
> > (SanDisk UHS-II card on GL9755 controller)
> >                              Read    Write
> > UHS-II disabled (UHS-I): 88.3MB/s 60.7MB/s
> > UHS-II enabled         :  206MB/s   80MB/s
> >
> > TODO
> > =3D=3D=3D=3D
> > - replace some define with BIT macro
> >
> > Reference
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [1] https://gitlab.com/ben.chuang/linux-uhs2-gl9755.git
> > [2] SD Host Controller Simplified Specification 4.20
> > [3] UHS-II Simplified Addendum 1.02
> >
> > Changes in v3 (Jul. 10, 2020)
> > * rebased to v5.8-rc4
> > * add copyright notice
> > * reorganize the patch set and split some commits into smaller ones
> > * separate uhs-2 headers from others
> > * correct wrong spellings
> > * fix most of checkpatch warnings/errors
> > * remove all k[cz]alloc() from the code
> > * guard sdhci-uhs2 specific code with
> >       'if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2))'
> > * make sdhci-uhs2.c as a module
> > * trivial changes, including
> >   - rename back sdhci-core.c to sdhci.c
> >   - allow vendor code to disable uhs2 if v4_mode =3D=3D 0
> >       in __sdhci_add_host()
> >   - merge uhs2_power_up() into mmc_power_up()
> >   - remove flag_uhs2 from mmc_attach_sd()
> >   - add function descriptions to EXPORT'ed functions
> >   - other minor code optimization
> >
> > Changes in v2 (Jan. 9, 2020)
> > * rebased to v5.5-rc5
> >
> > Ben Chuang (1):
> >   mmc: sdhci-uhs2: add pre-detect_init hook
> >
> > Ulf Hansson (4):
> >   mmc: core: Cleanup printing of speed mode at card insertion
> >   mmc: core: Prepare to support SD UHS-II cards
> >   mmc: core: Announce successful insertion of an SD UHS-II card
> >   mmc: core: Extend support for mmc regulators with a vqmmc2
> >
> > Victor Shih (17):
> >   mmc: core: Add definitions for SD UHS-II cards
> >   mmc: core: Add New function to re-factoring the code
> >   mmc: core: Support UHS-II card control and access
> >   mmc: sdhci: add UHS-II related definitions in headers
> >   mmc: sdhci: add UHS-II module and add a kernel configuration
> >   mmc: sdhci-uhs2: dump UHS-II registers
> >   mmc: sdhci-uhs2: add reset function function
> >   mmc: sdhci-uhs2: add set_power() to support vdd2
> >   mmc: sdhci-uhs2: add set_timeout()
> >   mmc: sdhci-uhs2: add set_ios()
> >   mmc: sdhci-uhs2: add uhs2_control() to initialise the interface
> >   mmc: sdhci-uhs2: add request() and others
> >   mmc: sdhci-uhs2: add irq() and others
> >   mmc: sdhci-uhs2: add add_host() and others to set up the driver
> >   mmc: sdhci-pci: add UHS-II support framework
> >   mmc: sdhci-pci-gli: enable UHS-II mode for GL9755
> >   mmc: sdhci-pci-gli: enable UHS-II mode for GL9767
> >
> >  drivers/mmc/core/Makefile         |    2 +-
> >  drivers/mmc/core/bus.c            |   38 +-
> >  drivers/mmc/core/core.c           |   23 +-
> >  drivers/mmc/core/core.h           |    1 +
> >  drivers/mmc/core/mmc_ops.c        |   24 +-
> >  drivers/mmc/core/mmc_ops.h        |    1 +
> >  drivers/mmc/core/regulator.c      |   34 +
> >  drivers/mmc/core/sd.c             |   10 +-
> >  drivers/mmc/core/sd.h             |    5 +
> >  drivers/mmc/core/sd_ops.c         |    9 +
> >  drivers/mmc/core/sd_ops.h         |   13 +
> >  drivers/mmc/core/sd_uhs2.c        | 1326 +++++++++++++++++++++++++++++
> >  drivers/mmc/host/Kconfig          |   10 +
> >  drivers/mmc/host/Makefile         |    1 +
> >  drivers/mmc/host/sdhci-pci-core.c |   16 +-
> >  drivers/mmc/host/sdhci-pci-gli.c  |  382 ++++++++-
> >  drivers/mmc/host/sdhci-pci.h      |    3 +
> >  drivers/mmc/host/sdhci-uhs2.c     | 1272 +++++++++++++++++++++++++++
> >  drivers/mmc/host/sdhci-uhs2.h     |  190 +++++
> >  drivers/mmc/host/sdhci.c          |  281 +++---
> >  drivers/mmc/host/sdhci.h          |   75 +-
> >  include/linux/mmc/card.h          |   36 +
> >  include/linux/mmc/core.h          |   17 +
> >  include/linux/mmc/host.h          |   80 ++
> >  include/linux/mmc/sd_uhs2.h       |  240 ++++++
> >  25 files changed, 3939 insertions(+), 150 deletions(-)
> >  create mode 100644 drivers/mmc/core/sd_uhs2.c
> >  create mode 100644 drivers/mmc/host/sdhci-uhs2.c
> >  create mode 100644 drivers/mmc/host/sdhci-uhs2.h
> >  create mode 100644 include/linux/mmc/sd_uhs2.h
> >
>

