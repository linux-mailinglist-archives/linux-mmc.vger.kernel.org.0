Return-Path: <linux-mmc+bounces-3595-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFDB963FCE
	for <lists+linux-mmc@lfdr.de>; Thu, 29 Aug 2024 11:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79BB7B243D4
	for <lists+linux-mmc@lfdr.de>; Thu, 29 Aug 2024 09:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FB718CC19;
	Thu, 29 Aug 2024 09:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtsCQwc8"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4AB3E47B;
	Thu, 29 Aug 2024 09:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724923333; cv=none; b=oERqrPn/u2gVZll5i+KTk84EtoWNvy+PlB1g0Ah8xPOtZpEo9ujLHxQX06yDvqOQ8Llo79ZlVX4tmnO5JsfS6DBJdndKDBiHgWLe7g2YYzOJ9hSaTLVbkjAlhd/756ozbzOvTifmSxqUX5WVgQ4SE63iEK6qdrNqc+Sq+4yM/M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724923333; c=relaxed/simple;
	bh=1QSh/0I+AI/aki3dvB0SCVirlrMgdrehMhfnDFqh/ec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=la5sJ2uh52itS/rV7PHAtzxmPwZwUJSYExAJVu42+0gzIWDT7MSVUrIXdzAlhGvjF4G50bHAd+oaLHN5UH7FPjlDK2NfhfSoDmg/CpCgr43s4Djeya7RcK7RXosMm6wnZQA5EJDiAsvccADjN9YHN2GGk7BTYRroWxXXCY0zrHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AtsCQwc8; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-498cd1112c3so140615137.0;
        Thu, 29 Aug 2024 02:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724923328; x=1725528128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iM6JtjUBzZ4ytQ7RVvmX/RMldQ+DlaJVt/eimaaefcM=;
        b=AtsCQwc8E4R5xuhrQNxN/m2pO8hA2yrc0CBWMs7IQbWHkQ3yd1rWAwp9hw5/cdFpsz
         g0RtMBx8JeW6XMHd/Hca7YKQSn39xAZFa9KD7uWrX/EFImSrIxvIvqBudQ3WtOf1qCoh
         bnDDXSPh0ulvu/q6AdJcvBfq98UFomlb0yBLfWNnaBvBAIwH96HS6We0Yib9oM7uP8IO
         Q3sc/qrlcAspn2x1maUCjxTDdeiSCFZW67i+OKgaotdtCWuc8DY+znX+oNnSug+Q84HZ
         xQGcDKJxXca4YZvFATUsDTLsfg4UYtPQMYcLg+SusxFfkBrFaPQsh+STWtVp4fTowugP
         GnVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724923328; x=1725528128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iM6JtjUBzZ4ytQ7RVvmX/RMldQ+DlaJVt/eimaaefcM=;
        b=kauvvRX97SgzuYJDx5Nlh0BVMsDe0ofUq/xUlKhRa5HEN20AR9EL6VAsP5Jv1PVZJ6
         BeNhqS7JarpZbaqZ5TZZXaNofbAuGYDCjXMvWwy4oH5+eWdGcVzWMqLQS8+6UO0LdjL1
         KnrGf6x+kz8fk1g+JeIpDHqAaKTrih53Yzb6nojx73y+QbtG1D3TAJ+BbOghRTDRtM+0
         enXU0UCXkcy1qzNks1bSMgIEcj+vf6LLoyheSkhq923m+qB0w1sWSragBMcM5QdQaWBr
         zWekVh/CjyDfaMBPkYPsDLFhounMyiDiQ1w01DFeWT02wS38+TZWjXLABpZFpt6R5tce
         Qy1A==
X-Forwarded-Encrypted: i=1; AJvYcCVY5hZ0wjKu8dHIhPxZHm5snSIvRkaCxtsTgpJ/wmp2boRv3+x/xXaDkLwPnIdDqLPrwkj7P1BIim5czkk=@vger.kernel.org, AJvYcCXo/W7NenMSaJk7KJJrfYJMIynIj+/SAo5Lg2PDX+F5xGMk7UEpTM95yYgf7bpUNwZQ6jcGBEulNSrc@vger.kernel.org
X-Gm-Message-State: AOJu0YxYB4aShWUfnMgTKIkJbkBQiiYvpwDqSheGMxMdY8bRcWcxF009
	iV7t/w+Mcfot4c31vPc5aWn8i15yBCv5VNCa4sKCmL496CbaGocjHUenuACa3CEaMwqboYVW2Fg
	MqOSguusSm7PN7NOjkuRC+7CadKM=
X-Google-Smtp-Source: AGHT+IGlKFs/3iJ/cB5nXiYa9niEs7R7YaH0cNLCYZY53GrDt7hHVHFuTy+Sw4ftx9bRX3GVaaW80e+rowxQSSCSDNo=
X-Received: by 2002:a05:6102:3f0f:b0:493:e587:3251 with SMTP id
 ada2fe7eead31-49a5af35d41mr2955937137.20.1724923327754; Thu, 29 Aug 2024
 02:22:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802102229.10204-1-victorshihgli@gmail.com>
 <CAK00qKDcxyoy2SJQBGbP8hVAX+nxQCSC4zCYu74g9jA5f-ha3w@mail.gmail.com>
 <CAK00qKAQmMRz2sy9qiEOnR4n=aF053a5M8jq7oP399K0QRwMVw@mail.gmail.com>
 <98012929-3642-4bb0-a01f-371a6ccc0264@intel.com> <CAK00qKAV8ZXvDcQjxd1BgmmsEu9VsZicPZ7EPQbzKg9-GngTzw@mail.gmail.com>
 <CAPDyKFrX=PxHCrGX-NFLk57dH0AVY3foMKN+K7TSyaLwA_TVdg@mail.gmail.com>
In-Reply-To: <CAPDyKFrX=PxHCrGX-NFLk57dH0AVY3foMKN+K7TSyaLwA_TVdg@mail.gmail.com>
From: Victor Shih <victorshihgli@gmail.com>
Date: Thu, 29 Aug 2024 17:21:55 +0800
Message-ID: <CAK00qKBvJMkYqyRkoJk4AV8k3-D_W0nOBHOv31Vems3nH66FYA@mail.gmail.com>
Subject: Re: [PATCH V18 00/22] Add support UHS-II for GL9755 and GL9767
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, benchuanggli@gmail.com, 
	Lucas.Lai@genesyslogic.com.tw, HL.Liu@genesyslogic.com.tw, 
	Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org, dlunev@chromium.org, 
	Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 10:36=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
>
> On Tue, 27 Aug 2024 at 12:20, Victor Shih <victorshihgli@gmail.com> wrote=
:
> >
> > Hi, Ulf
> >
> > Sorry for bothering you again and again.
> > I'm not sure if I'm missing something, or if there are any steps I
> > need to complete first.
> > I hope to get your opinions on this series of patches,
> > so that this series of patches can move forward to the next step.
> > Please help review this series of patches and let me know if there are
> > any that need to be modified.
> > I look forward to your reply.
> >
> > Thanks, Victor Shih
>
> Hi Victor,
>
> Basically I have been prioritizing my review bandwidth. I have already
> spent a lot of time reviewing and helping to move this series forward,
> but I am simply worried that I will be wasting bandwidth if/when I am
> looking into this again.
>
> That said, I will await for you to send another new version to address
> Adrian's final comments for the sdhci parts. Then I will try to review
> it one more time.
>
> Kind regards
> Uffe
>

Hi, Ulf

Thank you very much for your reply, I will submit the patches for the
new version
as soon as possible.

Thanks, Victor Shih

> >
> > On Fri, Aug 23, 2024 at 8:45=E2=80=AFPM Adrian Hunter <adrian.hunter@in=
tel.com> wrote:
> > >
> > > On 22/08/24 17:58, Victor Shih wrote:
> > > > Hi, Ulf and Adrian
> > > >
> > > > Sorry for bothering you again, May I know the status of this series=
 of patches?
> > > > Please help review this series of patches and let me know if there =
are
> > > > any that need to be modified.
> > > > I look forward to your reply.
> > >
> > > I noticed a few small things and replied to the relevent
> > > emails, but, as I wrote for V17, this is essentially OK from
> > > my point of view.
> > >
> >
> > Hi, Adrian
> >
> > Thank you for your feedback, I will correct it in the next version.
> >
> > Thanks, Victor Shih
> >
> > > >
> > > > Thanks, Victor Shih
> > > >
> > > > On Thu, Aug 15, 2024 at 6:26=E2=80=AFPM Victor Shih <victorshihgli@=
gmail.com> wrote:
> > > >>
> > > >> Hi, Ulf
> > > >>
> > > >> Sorry for bothering you.
> > > >> Please help review this series of patches.
> > > >> I hope to get your feedback to confirm whether there are any needs=
 to
> > > >> be modified.
> > > >> If you already have a closer look at a paragraph in the series, co=
uld
> > > >> you let me know your opinions first.
> > > >> I look forward to your reply.
> > > >>
> > > >> Thanks, Victor Shih
> > > >>
> > > >> Hi, Adrian
> > > >>
> > > >> Please help review this series of patches.
> > > >> In this series of patches, I only patch#17 file and patch#22.
> > > >> I look forward to receiving your reply.
> > > >>
> > > >> Thanks, Victor Shih
> > > >>
> > > >> On Fri, Aug 2, 2024 at 6:22=E2=80=AFPM Victor Shih <victorshihgli@=
gmail.com> wrote:
> > > >>>
> > > >>> From: Victor Shih <victor.shih@genesyslogic.com.tw>
> > > >>>
> > > >>> Summary
> > > >>> =3D=3D=3D=3D=3D=3D=3D
> > > >>> These patches[1] support UHS-II and fix GL9755 and GL9767
> > > >>> UHS-II compatibility.
> > > >>>
> > > >>> About UHS-II, roughly deal with the following three parts:
> > > >>> 1) A UHS-II detection and initialization:
> > > >>> - Host setup to support UHS-II (Section 3.13.1 Host Controller Se=
tup
> > > >>>   Sequence[2]).
> > > >>> - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Se=
quence
> > > >>>   [2]).
> > > >>> - In step(9) of Section 3.13.2 in [2], UHS-II initialization is i=
nclude
> > > >>>   Section 3.13.3 UHS-II Card Initialization and Section 3.13.4 UH=
S-II
> > > >>>   Setting Register Setup Sequence.
> > > >>>
> > > >>> 2) Send Legacy SD command through SD-TRAN
> > > >>> - Encapsulated SD packets are defined in SD-TRAN in order to ensu=
re Legacy
> > > >>>   SD compatibility and preserve Legacy SD infrastructures (Sectio=
n 7.1.1
> > > >>>   Packet Types and Format Overview[3]).
> > > >>> - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.=
5 UHS-II
> > > >>>   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issui=
ng[2]).
> > > >>>
> > > >>> 3) UHS-II Interrupt
> > > >>> - Except for UHS-II error interrupts, most interrupts share the o=
riginal
> > > >>>   interrupt registers.
> > > >>>
> > > >>> Patch structure
> > > >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >>> patch#1-#7:  for core
> > > >>> patch#8-#20: for sdhci
> > > >>> patch#21:    for GL9755
> > > >>> patch#22:    for GL9767
> > > >>>
> > > >>> Tests
> > > >>> =3D=3D=3D=3D=3D
> > > >>> Ran 'dd' command to evaluate the performance:
> > > >>> (SanDisk UHS-II card on GL9755 controller)
> > > >>>                              Read    Write
> > > >>> UHS-II disabled (UHS-I): 83.9MB/s 48.6MB/s
> > > >>> UHS-II enabled         :  199MB/s 74.3MB/s
> > > >>> (SanDisk UHS-II card on GL9767 controller)
> > > >>>                              Read    Write
> > > >>> UHS-II disabled (UHS-I): 83.6MB/s 50.1MB/s
> > > >>> UHS-II enabled         :  183MB/s 77.8MB/s
> > > >>>
> > > >>> Changes in v18 (August. 02, 2024)
> > > >>> * Rebase on latest mmc/next.
> > > >>> * Patch#17: Modify the judgment condition in sdhci_uhs2_reset_cmd=
_data()
> > > >>>             and replace it from mmc_card_uhs2()
> > > >>>             to host->mmc->uhs2_sd_tran flag.
> > > >>> * Patch#22: Add new register settings for gl9767.
> > > >>>             Add card_event in the sdhci_ops for gl9767.
> > > >>>             Add sdhci_gl9767_set_card_detect_debounce_time()
> > > >>>             to configure the gl9767.
> > > >>>             Adjust the sdhci_gl9767_reset() process for gl9767.
> > > >>>
> > > >>> Reference
> > > >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >>> [1] https://gitlab.com/VictorShih/linux-uhs2.git
> > > >>> [2] SD Host Controller Simplified Specification 4.20
> > > >>> [3] UHS-II Simplified Addendum 1.02
> > > >>> [4] https://patchwork.kernel.org/project/linux-mmc/cover/20240620=
104444.5862-1-victorshihgli@gmail.com/
> > > >>>
> > > >>> ----------------- original cover letter from v17 ----------------=
-
> > > >>> Summary
> > > >>> =3D=3D=3D=3D=3D=3D=3D
> > > >>> These patches[1] support UHS-II and fix GL9755 and GL9767
> > > >>> UHS-II compatibility.
> > > >>>
> > > >>> About UHS-II, roughly deal with the following three parts:
> > > >>> 1) A UHS-II detection and initialization:
> > > >>> - Host setup to support UHS-II (Section 3.13.1 Host Controller Se=
tup
> > > >>>   Sequence[2]).
> > > >>> - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Se=
quence
> > > >>>   [2]).
> > > >>> - In step(9) of Section 3.13.2 in [2], UHS-II initialization is i=
nclude
> > > >>>   Section 3.13.3 UHS-II Card Initialization and Section 3.13.4 UH=
S-II
> > > >>>   Setting Register Setup Sequence.
> > > >>>
> > > >>> 2) Send Legacy SD command through SD-TRAN
> > > >>> - Encapsulated SD packets are defined in SD-TRAN in order to ensu=
re Legacy
> > > >>>   SD compatibility and preserve Legacy SD infrastructures (Sectio=
n 7.1.1
> > > >>>   Packet Types and Format Overview[3]).
> > > >>> - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.=
5 UHS-II
> > > >>>   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issui=
ng[2]).
> > > >>>
> > > >>> 3) UHS-II Interrupt
> > > >>> - Except for UHS-II error interrupts, most interrupts share the o=
riginal
> > > >>>   interrupt registers.
> > > >>>
> > > >>> Patch structure
> > > >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >>> patch#1-#7:  for core
> > > >>> patch#8-#20: for sdhci
> > > >>> patch#21:    for GL9755
> > > >>> patch#22:    for GL9767
> > > >>>
> > > >>> Changes in v17 (June. 20, 2024)
> > > >>> * Rebase on latest mmc/next.
> > > >>> * Drop patch#8 of uhs2 patches series v16.
> > > >>> * Patch#11: Move the sdhci_uhs2_reset_cmd_data() to the other pat=
ch
> > > >>>             it was used for the first time.
> > > >>> * Patch#12: Export sdhci_uhs2_set_power() function.
> > > >>> * Patch#16: Add new parameter to __sdhci_finish_data_common().
> > > >>> * Patch#17: Add sdhci_uhs2_reset_cmd_data() and sdhci_uhs2_needs_=
reset() to
> > > >>>             resolve the data error or cmd error.
> > > >>> * Patch#21: Rname gl9755_overcurrent_event_enable() to
> > > >>>             sdhci_gli_overcurrent_event_enable().
> > > >>> * Patch#22: Use mmc_card_uhs2() to simplify the code in the
> > > >>>             sdhci_gl9767_reset().
> > > >>>             Use mmc_card_uhs2() to simplify the code in the
> > > >>>             sdhci_gl9767_set_power().
> > > >>>             Add sdhci_gli_overcurrent_event_enable() to
> > > >>>             sdhci_gl9767_set_power().
> > > >>>
> > > >>> Reference
> > > >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >>> [1] https://gitlab.com/VictorShih/linux-uhs2.git
> > > >>> [2] SD Host Controller Simplified Specification 4.20
> > > >>> [3] UHS-II Simplified Addendum 1.02
> > > >>> [4] https://patchwork.kernel.org/project/linux-mmc/cover/20240522=
110909.10060-1-victorshihgli@gmail.com/
> > > >>>
> > > >>> ----------------- original cover letter from v16 ----------------=
-
> > > >>> Summary
> > > >>> =3D=3D=3D=3D=3D=3D=3D
> > > >>> These patches[1] support UHS-II and fix GL9755 and GL9767
> > > >>> UHS-II compatibility.
> > > >>>
> > > >>> About UHS-II, roughly deal with the following three parts:
> > > >>> 1) A UHS-II detection and initialization:
> > > >>> - Host setup to support UHS-II (Section 3.13.1 Host Controller Se=
tup
> > > >>>   Sequence[2]).
> > > >>> - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Se=
quence
> > > >>>   [2]).
> > > >>> - In step(9) of Section 3.13.2 in [2], UHS-II initialization is i=
nclude
> > > >>>   Section 3.13.3 UHS-II Card Initialization and Section 3.13.4 UH=
S-II
> > > >>>   Setting Register Setup Sequence.
> > > >>>
> > > >>> 2) Send Legacy SD command through SD-TRAN
> > > >>> - Encapsulated SD packets are defined in SD-TRAN in order to ensu=
re Legacy
> > > >>>   SD compatibility and preserve Legacy SD infrastructures (Sectio=
n 7.1.1
> > > >>>   Packet Types and Format Overview[3]).
> > > >>> - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.=
5 UHS-II
> > > >>>   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issui=
ng[2]).
> > > >>>
> > > >>> 3) UHS-II Interrupt
> > > >>> - Except for UHS-II error interrupts, most interrupts share the o=
riginal
> > > >>>   interrupt registers.
> > > >>>
> > > >>> Patch structure
> > > >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >>> patch#1-#8:  for core
> > > >>> patch#9-#21: for sdhci
> > > >>> patch#22:    for GL9755
> > > >>> patch#23:    for GL9767
> > > >>>
> > > >>> Changes in v16 (May. 22, 2024)
> > > >>> * rebased to the linux-kernel-v6.9.0-rc2 in Ulf Hansson next bran=
ch.
> > > >>> * according to the comments provided by Adrian Hunter to modify t=
he
> > > >>>   patches base on the [V14 00/21] Add support UHS-II for GL9755.
> > > >>> * Patch#8: Separate the Error Recovery mechanism from patch#7 to =
patch#8.
> > > >>> * Patch#16: Remove irrelevant definition in the sdhci_calc_timeou=
t_uhs2().
> > > >>>
> > > >>> Reference
> > > >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >>> [1] https://gitlab.com/VictorShih/linux-uhs2.git
> > > >>> [2] SD Host Controller Simplified Specification 4.20
> > > >>> [3] UHS-II Simplified Addendum 1.02
> > > >>> [4] https://patchwork.kernel.org/project/linux-mmc/cover/20240123=
062827.8525-1-victorshihgli@gmail.com/
> > > >>>
> > > >>> ----------------- original cover letter from v15 ----------------=
-
> > > >>> Summary
> > > >>> =3D=3D=3D=3D=3D=3D=3D
> > > >>> These patches[1] support UHS-II and fix GL9755 and GL9767
> > > >>> UHS-II compatibility.
> > > >>>
> > > >>> About UHS-II, roughly deal with the following three parts:
> > > >>> 1) A UHS-II detection and initialization:
> > > >>> - Host setup to support UHS-II (Section 3.13.1 Host Controller Se=
tup
> > > >>>   Sequence[2]).
> > > >>> - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Se=
quence
> > > >>>   [2]).
> > > >>> - In step(9) of Section 3.13.2 in [2], UHS-II initialization is i=
nclude
> > > >>>   Section 3.13.3 UHS-II Card Initialization and Section 3.13.4 UH=
S-II
> > > >>>   Setting Register Setup Sequence.
> > > >>>
> > > >>> 2) Send Legacy SD command through SD-TRAN
> > > >>> - Encapsulated SD packets are defined in SD-TRAN in order to ensu=
re Legacy
> > > >>>   SD compatibility and preserve Legacy SD infrastructures (Sectio=
n 7.1.1
> > > >>>   Packet Types and Format Overview[3]).
> > > >>> - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.=
5 UHS-II
> > > >>>   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issui=
ng[2]).
> > > >>>
> > > >>> 3) UHS-II Interrupt
> > > >>> - Except for UHS-II error interrupts, most interrupts share the o=
riginal
> > > >>>   interrupt registers.
> > > >>>
> > > >>> Patch structure
> > > >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >>> patch#1-#7:  for core
> > > >>> patch#8-#20: for sdhci
> > > >>> patch#21:    for GL9755
> > > >>> patch#22:    for GL9767
> > > >>>
> > > >>> Changes in v15 (April. 22, 2024)
> > > >>> * rebased to the linux-kernel-v6.9.0-rc2 in Ulf Hansson next bran=
ch.
> > > >>> * according to the comments provided by Adrian Hunter to modify t=
he
> > > >>>   patches base on the [V14 00/21] Add support UHS-II for GL9755.
> > > >>> * Patch#07: Move struct uhs2_command uhs2_cmd to struct mmc_reque=
st and
> > > >>>             modify whatever other changers to make it work.
> > > >>>             Refer the SD Host Controller Standard Specification
> > > >>>             Section 3.10 to add Error Recovery mechanism to recov=
er
> > > >>>             the command error.
> > > >>> * Patch#11: Refer the SD Host Controller Standard Specification
> > > >>>             Section 3.10 to add reset command data mechanism.
> > > >>> * Patch#15: Resolve merge conflicts and reduce unnecessary line b=
reaks.
> > > >>> * Patch#16: Adjust the parameters used in the __sdhci_uhs2_finish=
_command()
> > > >>>             to match changes in the Patch#7.
> > > >>> * Patch#21: Adjust gl9755_vendor_init() to the correct function.
> > > >>> * Patch#22: Add gl9767 to support uhs2 function.
> > > >>>
> > > >>> Reference
> > > >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >>> [1] https://gitlab.com/VictorShih/linux-uhs2.git
> > > >>> [2] SD Host Controller Simplified Specification 4.20
> > > >>> [3] UHS-II Simplified Addendum 1.02
> > > >>> [4] https://patchwork.kernel.org/project/linux-mmc/cover/20240123=
062827.8525-1-victorshihgli@gmail.com/
> > > >>>
> > > >>> ----------------- original cover letter from v14 ----------------=
-
> > > >>> Summary
> > > >>> =3D=3D=3D=3D=3D=3D=3D
> > > >>> These patches[1] support UHS-II and fix GL9755 UHS-II compatibili=
ty.
> > > >>>
> > > >>> About UHS-II, roughly deal with the following three parts:
> > > >>> 1) A UHS-II detection and initialization:
> > > >>> - Host setup to support UHS-II (Section 3.13.1 Host Controller Se=
tup
> > > >>>   Sequence[2]).
> > > >>> - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Se=
quence
> > > >>>   [2]).
> > > >>> - In step(9) of Section 3.13.2 in [2], UHS-II initialization is i=
nclude
> > > >>>   Section 3.13.3 UHS-II Card Initialization and Section 3.13.4 UH=
S-II
> > > >>>   Setting Register Setup Sequence.
> > > >>>
> > > >>> 2) Send Legacy SD command through SD-TRAN
> > > >>> - Encapsulated SD packets are defined in SD-TRAN in order to ensu=
re Legacy
> > > >>>   SD compatibility and preserve Legacy SD infrastructures (Sectio=
n 7.1.1
> > > >>>   Packet Types and Format Overview[3]).
> > > >>> - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.=
5 UHS-II
> > > >>>   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issui=
ng[2]).
> > > >>>
> > > >>> 3) UHS-II Interrupt
> > > >>> - Except for UHS-II error interrupts, most interrupts share the o=
riginal
> > > >>>   interrupt registers.
> > > >>>
> > > >>> Patch structure
> > > >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >>> patch#1-#7:  for core
> > > >>> patch#8-#20: for sdhci
> > > >>> patch#21:    for GL9755
> > > >>>
> > > >>> Changes in v14 (January. 23, 2024)
> > > >>> * rebased to the linux-kernel-v6.7.0-rc4 in Ulf Hansson next bran=
ch.
> > > >>> * according to the comments provided by Adrian Hunter to modify t=
he
> > > >>>   patches base on the [V13 00/21] Add support UHS-II for GL9755.
> > > >>> * Patch#03: Move mmc_card_uhs2() to include/linux/mmc/host.h, so =
that
> > > >>>             mmc_card_uhs2() can be available for host drivers.
> > > >>> * Patch#10: Use mmc_card_uhs2() to stead sdhci_uhs2_mode() in the
> > > >>>             sdhci_uhs2_dump_regs().
> > > >>> * Patch#11: Since mmc_card_uhs2() is the same as sdhci_uhs2_mode(=
), so
> > > >>>             drop sdhci_uhs2_mode() and use mmc_card_uhs2() instea=
d of
> > > >>>             sdhci_uhs2_mode().
> > > >>> * Patch#13: Use mmc_card_uhs2() to stead sdhci_uhs2_mode() in the
> > > >>>             sdhci_uhs2_set_timeout().
> > > >>> * Patch#14: Use mmc_card_uhs2() to stead sdhci_uhs2_mode() in the
> > > >>>             sdhci_uhs2_set_ios().
> > > >>> * Patch#16: Use mmc_card_uhs2() to stead sdhci_uhs2_mode() in the
> > > >>>             sdhci_uhs2_request().
> > > >>> * Patch#17: Use mmc_card_uhs2() to stead sdhci_uhs2_mode() in the
> > > >>>             sdhci_uhs2_complete_work(), sdhci_uhs2_irq() and
> > > >>>             sdhci_uhs2_thread_irq().
> > > >>> * Patch#18: Use mmc_card_uhs2() to stead sdhci_uhs2_mode() in the
> > > >>>             __sdhci_uhs2_remove_host().
> > > >>>
> > > >>> Reference
> > > >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >>> [1] https://gitlab.com/VictorShih/linux-uhs2.git
> > > >>> [2] SD Host Controller Simplified Specification 4.20
> > > >>> [3] UHS-II Simplified Addendum 1.02
> > > >>> [4] https://patchwork.kernel.org/project/linux-mmc/cover/20230915=
094351.11120-1-victorshihgli@gmail.com/
> > > >>>
> > > >>> ----------------- original cover letter from v13 ----------------=
-
> > > >>> Summary
> > > >>> =3D=3D=3D=3D=3D=3D=3D
> > > >>> These patches[1] support UHS-II and fix GL9755 UHS-II compatibili=
ty.
> > > >>>
> > > >>> About UHS-II, roughly deal with the following three parts:
> > > >>> 1) A UHS-II detection and initialization:
> > > >>> - Host setup to support UHS-II (Section 3.13.1 Host Controller Se=
tup
> > > >>>   Sequence[2]).
> > > >>> - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Se=
quence
> > > >>>   [2]).
> > > >>> - In step(9) of Section 3.13.2 in [2], UHS-II initialization is i=
nclude
> > > >>>   Section 3.13.3 UHS-II Card Initialization and Section 3.13.4 UH=
S-II
> > > >>>   Setting Register Setup Sequence.
> > > >>>
> > > >>> 2) Send Legacy SD command through SD-TRAN
> > > >>> - Encapsulated SD packets are defined in SD-TRAN in order to ensu=
re Legacy
> > > >>>   SD compatibility and preserve Legacy SD infrastructures (Sectio=
n 7.1.1
> > > >>>   Packet Types and Format Overview[3]).
> > > >>> - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.=
5 UHS-II
> > > >>>   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issui=
ng[2]).
> > > >>>
> > > >>> 3) UHS-II Interrupt
> > > >>> - Except for UHS-II error interrupts, most interrupts share the o=
riginal
> > > >>>   interrupt registers.
> > > >>>
> > > >>> Patch structure
> > > >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >>> patch#1-#7:  for core
> > > >>> patch#8-#20: for sdhci
> > > >>> patch#21:    for GL9755
> > > >>>
> > > >>> Changes in v13 (November. 17, 2023)
> > > >>> * rebased to the linux-kernel-v6.7.0-rc1 in Ulf Hansson next bran=
ch.
> > > >>> * according to the comments provided by Adrian Hunter to modify t=
he
> > > >>>   patches base on the [V12 00/23] Add support UHS-II for GL9755.
> > > >>> * according to the comments provided by Ulf Hansson to modify the
> > > >>>   patches base on the [V12 00/23] Add support UHS-II for GL9755.
> > > >>> * Add new patch#6 to re-factoring the code.
> > > >>> * Patch#7: Separate __mmc_go_idle() into one patch for re-factorr=
ing the code.
> > > >>>            Move mmc_decode_scr declaration to sd.h.
> > > >>>            Ues uhs2_sd_tran to stead MMC_UHS2_SD_TRAN.
> > > >>>            Drop unnecessary comment.
> > > >>> * Patch#11: Use ios timing to stead MMC_UHS2_SUPPORT for indicate=
 the UHS2 mode.
> > > >>> * Patch#12: Drop use vmmc2.
> > > >>>             Modify comment message.
> > > >>> * Patch#13: Modify comment message.
> > > >>> * Patch#14: Add judgment condition for power mode in the __sdhci_=
uhs2_set_ios().
> > > >>>             Modify comment message.
> > > >>> * Patch#15: Merge Patch#15, Patch#16 and Patch#17 of v12 version =
into Patch#15 in v13 version.
> > > >>>             Use definitions to simplify code.
> > > >>>             Modify comment message.
> > > >>> * Patch#16: Re-order function to avoid declaration.
> > > >>>             Remove unnecessary function.
> > > >>> * Patch#17: Re-order function to avoid declaration.
> > > >>>             Remove unnecessary definitions.
> > > >>> * Patch#18: Re-order function to avoid declaration.
> > > >>>             Use vqmmc2 to stead vmmc2.
> > > >>> * Patch#21: Ues uhs2_sd_tran to stead MMC_UHS2_SD_TRAN.
> > > >>>
> > > >>> Reference
> > > >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >>> [1] https://gitlab.com/VictorShih/linux-uhs2.git
> > > >>> [2] SD Host Controller Simplified Specification 4.20
> > > >>> [3] UHS-II Simplified Addendum 1.02
> > > >>> [4] https://patchwork.kernel.org/project/linux-mmc/cover/20230915=
094351.11120-1-victorshihgli@gmail.com/
> > > >>>
> > > >>> ----------------- original cover letter from v12 ----------------=
-
> > > >>> Summary
> > > >>> =3D=3D=3D=3D=3D=3D=3D
> > > >>> These patches[1] support UHS-II and fix GL9755 UHS-II compatibili=
ty.
> > > >>>
> > > >>> About UHS-II, roughly deal with the following three parts:
> > > >>> 1) A UHS-II detection and initialization:
> > > >>> - Host setup to support UHS-II (Section 3.13.1 Host Controller Se=
tup
> > > >>>   Sequence[2]).
> > > >>> - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Se=
quence
> > > >>>   [2]).
> > > >>> - In step(9) of Section 3.13.2 in [2], UHS-II initialization is i=
nclude
> > > >>>   Section 3.13.3 UHS-II Card Initialization and Section 3.13.4 UH=
S-II
> > > >>>   Setting Register Setup Sequence.
> > > >>>
> > > >>> 2) Send Legacy SD command through SD-TRAN
> > > >>> - Encapsulated SD packets are defined in SD-TRAN in order to ensu=
re Legacy
> > > >>>   SD compatibility and preserve Legacy SD infrastructures (Sectio=
n 7.1.1
> > > >>>   Packet Types and Format Overview[3]).
> > > >>> - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.=
5 UHS-II
> > > >>>   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issui=
ng[2]).
> > > >>>
> > > >>> 3) UHS-II Interrupt
> > > >>> - Except for UHS-II error interrupts, most interrupts share the o=
riginal
> > > >>>   interrupt registers.
> > > >>>
> > > >>> Patch structure
> > > >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >>> patch#1-#6:  for core
> > > >>> patch#7-#22: for sdhci
> > > >>> patch#23:    for GL9755
> > > >>>
> > > >>> Changes in v12 (September. 15, 2023)
> > > >>> * rebased to the linux-kernel-v6.6.0-rc1 in Ulf Hansson next bran=
ch.
> > > >>> * according to the comments provided by Adrian Hunter to modify t=
he
> > > >>>   patches base on the [V11 00/23] Add support UHS-II for GL9755.
> > > >>> * according to the comments provided by Ulf Hansson to modify the
> > > >>>   patches base on the [V11 00/23] Add support UHS-II for GL9755.
> > > >>> * Patch#5: Remove unused max_current_180_vdd2.
> > > >>> * Patch#6: Use mmc_op_multi() to check DCMD which supports multi
> > > >>>            read/write in mmc_uhs2_prepare_cmd().
> > > >>>
> > > >>> Reference
> > > >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >>> [1] https://gitlab.com/VictorShih/linux-uhs2.git
> > > >>> [2] SD Host Controller Simplified Specification 4.20
> > > >>> [3] UHS-II Simplified Addendum 1.02
> > > >>> [4] https://patchwork.kernel.org/project/linux-mmc/cover/20230908=
095330.12075-1-victorshihgli@gmail.com/
> > > >>>
> > > >>> ----------------- original cover letter from v11 ----------------=
-
> > > >>> Summary
> > > >>> =3D=3D=3D=3D=3D=3D=3D
> > > >>> These patches[1] support UHS-II and fix GL9755 UHS-II compatibili=
ty.
> > > >>>
> > > >>> About UHS-II, roughly deal with the following three parts:
> > > >>> 1) A UHS-II detection and initialization:
> > > >>> - Host setup to support UHS-II (Section 3.13.1 Host Controller Se=
tup
> > > >>>   Sequence[2]).
> > > >>> - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Se=
quence
> > > >>>   [2]).
> > > >>> - In step(9) of Section 3.13.2 in [2], UHS-II initialization is i=
nclude
> > > >>>   Section 3.13.3 UHS-II Card Initialization and Section 3.13.4 UH=
S-II
> > > >>>   Setting Register Setup Sequence.
> > > >>>
> > > >>> 2) Send Legacy SD command through SD-TRAN
> > > >>> - Encapsulated SD packets are defined in SD-TRAN in order to ensu=
re Legacy
> > > >>>   SD compatibility and preserve Legacy SD infrastructures (Sectio=
n 7.1.1
> > > >>>   Packet Types and Format Overview[3]).
> > > >>> - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.=
5 UHS-II
> > > >>>   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issui=
ng[2]).
> > > >>>
> > > >>> 3) UHS-II Interrupt
> > > >>> - Except for UHS-II error interrupts, most interrupts share the o=
riginal
> > > >>>   interrupt registers.
> > > >>>
> > > >>> Patch structure
> > > >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >>> patch#1-#6:  for core
> > > >>> patch#7-#22: for sdhci
> > > >>> patch#23:    for GL9755
> > > >>>
> > > >>> Changes in v11 (September. 08, 2023)
> > > >>> * rebased to the linux-kernel-v6.5.0-rc5 in Ulf Hansson next bran=
ch.
> > > >>> * according to the comments provided by Adrian Hunter to modify t=
he
> > > >>>   patches base on the [V10 00/23] Add support UHS-II for GL9755.
> > > >>> * Patch#18: Drop the check mmc_card_uhs2_hd_mode(host->mmc)
> > > >>>             in sdhci_uhs2_set_transfer_mode().
> > > >>> * Patch#20: Remove unused ocr_avail_uhs2.
> > > >>>
> > > >>> Reference
> > > >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >>> [1] https://gitlab.com/VictorShih/linux-uhs2.git
> > > >>> [2] SD Host Controller Simplified Specification 4.20
> > > >>> [3] UHS-II Simplified Addendum 1.02
> > > >>> [4] https://patchwork.kernel.org/project/linux-mmc/cover/20230721=
101349.12387-1-victorshihgli@gmail.com/
> > > >>>
> > > >>> ----------------- original cover letter from v10 ----------------=
-
> > > >>> Summary
> > > >>> =3D=3D=3D=3D=3D=3D=3D
> > > >>> These patches[1] support UHS-II and fix GL9755 UHS-II compatibili=
ty.
> > > >>>
> > > >>> About UHS-II, roughly deal with the following three parts:
> > > >>> 1) A UHS-II detection and initialization:
> > > >>> - Host setup to support UHS-II (Section 3.13.1 Host Controller Se=
tup
> > > >>>   Sequence[2]).
> > > >>> - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Se=
quence
> > > >>>   [2]).
> > > >>> - In step(9) of Section 3.13.2 in [2], UHS-II initialization is i=
nclude
> > > >>>   Section 3.13.3 UHS-II Card Initialization and Section 3.13.4 UH=
S-II
> > > >>>   Setting Register Setup Sequence.
> > > >>>
> > > >>> 2) Send Legacy SD command through SD-TRAN
> > > >>> - Encapsulated SD packets are defined in SD-TRAN in order to ensu=
re Legacy
> > > >>>   SD compatibility and preserve Legacy SD infrastructures (Sectio=
n 7.1.1
> > > >>>   Packet Types and Format Overview[3]).
> > > >>> - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.=
5 UHS-II
> > > >>>   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issui=
ng[2]).
> > > >>>
> > > >>> 3) UHS-II Interrupt
> > > >>> - Except for UHS-II error interrupts, most interrupts share the o=
riginal
> > > >>>   interrupt registers.
> > > >>>
> > > >>> Patch structure
> > > >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >>> patch#1-#6:  for core
> > > >>> patch#7-#22: for sdhci
> > > >>> patch#23:    for GL9755
> > > >>>
> > > >>> Changes in v10 (August. 18, 2023)
> > > >>> * rebased to the linux-kernel-v6.5.0-rc5 in Ulf Hansson next bran=
ch.
> > > >>> * according to the comments provided by Ulf Hansson to modify the
> > > >>>   patches base on the [V9 00/23] Add support UHS-II for GL9755.
> > > >>> * Patch#2: Drop unnecessary definitions and code.
> > > >>> * Patch#3: Modify the commit message.
> > > >>> * Patch#4: Modify the commit message.
> > > >>> * Patch#5: Drop unnecessary definitions.
> > > >>> * Patch#6: Move some definitions of PatchV9[02/23] to PatchV10[06=
/23].
> > > >>>            Move some definitions of PatchV9[05/23] to PatchV10[06=
/23].
> > > >>>            Drop do_multi in the mmc_blk_rw_rq_prep().
> > > >>>            Use tmode_half_duplex to instead of uhs2_tmode0_flag.
> > > >>>            Move entire control of the tmode into mmc_uhs2_prepare=
_cmd().
> > > >>> * Patch#11: Move some definitions of PatchV9[05/23] to PatchV10[1=
1/23].
> > > >>> * Patch#18: Use tmode_half_duplex to instead of uhs2_tmode0_flag
> > > >>>             in sdhci_uhs2_set_transfer_mode().
> > > >>> * Patch#20: Move some definitions of PatchV9[05/23] to PatchV10[2=
0/23].
> > > >>>
> > > >>> Reference
> > > >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >>> [1] https://gitlab.com/VictorShih/linux-uhs2.git
> > > >>> [2] SD Host Controller Simplified Specification 4.20
> > > >>> [3] UHS-II Simplified Addendum 1.02
> > > >>> [4] https://patchwork.kernel.org/project/linux-mmc/cover/20230721=
101349.12387-1-victorshihgli@gmail.com/
> > > >>>
> > > >>> ----------------- original cover letter from v9 -----------------
> > > >>> Summary
> > > >>> =3D=3D=3D=3D=3D=3D=3D
> > > >>> These patches[1] support UHS-II and fix GL9755 UHS-II compatibili=
ty.
> > > >>>
> > > >>> About UHS-II, roughly deal with the following three parts:
> > > >>> 1) A UHS-II detection and initialization:
> > > >>> - Host setup to support UHS-II (Section 3.13.1 Host Controller Se=
tup
> > > >>>   Sequence[2]).
> > > >>> - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Se=
quence
> > > >>>   [2]).
> > > >>> - In step(9) of Section 3.13.2 in [2], UHS-II initialization is i=
nclude
> > > >>>   Section 3.13.3 UHS-II Card Initialization and Section 3.13.4 UH=
S-II
> > > >>>   Setting Register Setup Sequence.
> > > >>>
> > > >>> 2) Send Legacy SD command through SD-TRAN
> > > >>> - Encapsulated SD packets are defined in SD-TRAN in order to ensu=
re Legacy
> > > >>>   SD compatibility and preserve Legacy SD infrastructures (Sectio=
n 7.1.1
> > > >>>   Packet Types and Format Overview[3]).
> > > >>> - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.=
5 UHS-II
> > > >>>   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issui=
ng[2]).
> > > >>>
> > > >>> 3) UHS-II Interrupt
> > > >>> - Except for UHS-II error interrupts, most interrupts share the o=
riginal
> > > >>>   interrupt registers.
> > > >>>
> > > >>> Patch structure
> > > >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >>> patch#1-#6:  for core
> > > >>> patch#7-#22: for sdhci
> > > >>> patch#23:    for GL9755
> > > >>>
> > > >>> Changes in v9 (July. 21, 2023)
> > > >>> * rebased to the linux-kernel-v6.5.0-rc1 in Ulf Hansson next bran=
ch.
> > > >>> * according to the comments provided by Adrian Hunter to modify t=
he
> > > >>>   patches base on the [V8 00/23] Add support UHS-II for GL9755.
> > > >>> * Patch#2: move sd_uhs2_operation definition of PatchV8[05/23]
> > > >>>            to PatchV9[02/23] for avoid compilation errors.
> > > >>>            move uhs2_control definition of PatchV8[05/23]
> > > >>>            to PatchV9[02/23] for avoid compilation errors.
> > > >>>            move mmc_host flags definition of PatchV8[05/23]
> > > >>>            to PatchV9[02/23] for avoid compilation errors.
> > > >>>            move mmc_host flags MMC_UHS2_SUPPORT definition of
> > > >>>            PatchV8[05/23] to PatchV9[02/23] for avoid compilation=
 errors.
> > > >>>            move mmc_host flags MMC_UHS2_SD_TRAN definition of
> > > >>>            PatchV8[05/23] to PatchV9[02/23] for avoid compilation=
 errors.
> > > >>> * Patch#7: Modify the commit message.
> > > >>> * Patch#8: Modify the commit message.
> > > >>> * Patch#11: Modify annotations in sdhci_get_vdd_value().
> > > >>> * Patch#14: Simplity the turning_on_clk in sdhci_set_ios().
> > > >>> * Patch#18: Modify the annotations in __sdhci_uhs2_send_command()=
.
> > > >>> * Patch#19: Cancel export state of sdhci_set_mrq_done() function.
> > > >>> * Patch#23: Rename gl9755_pre_detect_init() to sdhci_gli_pre_dete=
ct_init().
> > > >>>             Rename gl9755_uhs2_reset_sd_tran() to
> > > >>>             sdhci_gli_uhs2_reset_sd_tran().
> > > >>>
> > > >>> Reference
> > > >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >>> [1] https://gitlab.com/VictorShih/linux-uhs2.git
> > > >>> [2] SD Host Controller Simplified Specification 4.20
> > > >>> [3] UHS-II Simplified Addendum 1.02
> > > >>> [4] https://patchwork.kernel.org/project/linux-mmc/cover/20230621=
100151.6329-1-victorshihgli@gmail.com/
> > > >>>
> > > >>> ----------------- original cover letter from v8 -----------------
> > > >>> Summary
> > > >>> =3D=3D=3D=3D=3D=3D=3D
> > > >>> These patches[1] support UHS-II and fix GL9755 UHS-II compatibili=
ty.
> > > >>>
> > > >>> About UHS-II, roughly deal with the following three parts:
> > > >>> 1) A UHS-II detection and initialization:
> > > >>> - Host setup to support UHS-II (Section 3.13.1 Host Controller Se=
tup
> > > >>>   Sequence[2]).
> > > >>> - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Se=
quence
> > > >>>   [2]).
> > > >>> - In step(9) of Section 3.13.2 in [2], UHS-II initialization is i=
nclude
> > > >>>   Section 3.13.3 UHS-II Card Initialization and Section 3.13.4 UH=
S-II
> > > >>>   Setting Register Setup Sequence.
> > > >>>
> > > >>> 2) Send Legacy SD command through SD-TRAN
> > > >>> - Encapsulated SD packets are defined in SD-TRAN in order to ensu=
re Legacy
> > > >>>   SD compatibility and preserve Legacy SD infrastructures (Sectio=
n 7.1.1
> > > >>>   Packet Types and Format Overview[3]).
> > > >>> - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.=
5 UHS-II
> > > >>>   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issui=
ng[2]).
> > > >>>
> > > >>> 3) UHS-II Interrupt
> > > >>> - Except for UHS-II error interrupts, most interrupts share the o=
riginal
> > > >>>   interrupt registers.
> > > >>>
> > > >>> Patch structure
> > > >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >>> patch#1-#6:  for core
> > > >>> patch#7-#22: for sdhci
> > > >>> patch#23:    for GL9755
> > > >>>
> > > >>> Changes in v8 (June. 21, 2023)
> > > >>> * rebased to the linux-kernel-v6.4.0-rc6 in Ulf Hansson next bran=
ch.
> > > >>> * fix most of checkpatch warnings/errors.
> > > >>> * according to the comments provided by Adrian Hunter to modify t=
he
> > > >>>   patches base on the [V7 00/23] Add support UHS-II for GL9755.
> > > >>> * Patch#6: Add MMC_UHS2_SUPPORT to be cleared in sd_uhs2_detect()=
.
> > > >>>            Modify return value in sd_uhs2_attach().
> > > >>> * Patch#7: Use tabs instead of spaces.
> > > >>> * Patch#8: Modify MODULE_LICENSE from "GPL v2" to "GPL".
> > > >>> * Patch#10: Adjust the position of matching brackets.
> > > >>> * Patch#11: Adjust the position of matching brackets.
> > > >>>             Add the initial value of the pwr in sdhci_uhs2_set_po=
wer().
> > > >>> * Patch#13: Initialization be combined with declaration and reali=
gned
> > > >>>             in sdhci_calc_timeout_uhs2().
> > > >>>             Forward declare struct mmc_command in sdhci_uhs2.h.
> > > >>> * Patch#14: Add the judgment formula for MMC_TIMING_SPEED_A_HD,
> > > >>>             MMC_TIMING_SPEED_B and MMC_TIMING_SPEED_B_HD in
> > > >>>             __sdhci_uhs2_set_ios().
> > > >>>             Add the switch case for MMC_TIMING_SPEED_A_HD,
> > > >>>             MMC_TIMING_SPEED_B and MMC_TIMING_SPEED_B_HD in
> > > >>>             sdhci_get_preset_value().
> > > >>>             mmc_opt_regulator_set_ocr() to instead of
> > > >>>             mmc_regulator_set_ocr() in sdhci_uhs2_set_ios().
> > > >>> * Patch#15: usleep_range() to instead of udelay() in
> > > >>>             sdhci_uhs2_interface_detect().
> > > >>>             read_poll_timeout() to instead of read_poll_timeout_a=
tomic()
> > > >>>             in sdhci_uhs2_interface_detect().
> > > >>>             Modify return value in sdhci_uhs2_do_detect_init().
> > > >>> * Patch#16: Remove unnecessary include file.
> > > >>>             read_poll_timeout() to instead of read_poll_timeout_a=
tomic()
> > > >>>             in sdhci_uhs2_enable_clk().
> > > >>>             Put the comment on the end and put the lines in desce=
nding
> > > >>>             line length in sdhci_uhs2_enable_clk().
> > > >>>             Modify return value in sdhci_uhs2_enable_clk().
> > > >>> * Patch#17: Reorder the definitions and lose the parentheses in
> > > >>>             sdhci_uhs2_set_config().
> > > >>>             read_poll_timeout() to instead of read_poll_timeout_a=
tomic()
> > > >>>             in sdhci_uhs2_check_dormant().
> > > >>> * Patch#18: Adjust the position of matching brackets in
> > > >>>             sdhci_uhs2_send_command_retry().
> > > >>>             Modify CameCase definition in __sdhci_uhs2_finish_com=
mand().
> > > >>>             Modify error message in __sdhci_uhs2_finish_command()=
.
> > > >>>             sdhci_uhs2_send_command_retry() to instead of
> > > >>>             sdhci_uhs2_send_command() in sdhci_uhs2_request().
> > > >>>             Use sdhci_uhs2_mode() to simplify code in
> > > >>>             sdhci_uhs2_request_atomic().
> > > >>>             Add forward declaration for sdhci_send_command().
> > > >>> * Patch#19: Forward declare struct mmc_request in sdhci_uhs2.h.
> > > >>>             Remove forward declaration of sdhci_send_command().
> > > >>>             Use mmc_dev() to simplify code in sdhci_request_done_=
dma().
> > > >>> * Patch#20: Change return type to void for __sdhci_uhs2_add_host_=
v4().
> > > >>>             Remove unused variables in __sdhci_uhs2_add_host_v4()=
.
> > > >>> * Patch#22: Add config select MMC_SDHCI_UHS2 in Kconfig.
> > > >>> * Patch#23: Use sdhci_get_vdd_value() to simplify code in
> > > >>>             gl9755_set_power().
> > > >>>             Use read_poll_timeout_atomic() to simplify code in
> > > >>>             sdhci_wait_clock_stable().
> > > >>>             Use read_poll_timeout_atomic() to simplify code in
> > > >>>             sdhci_gl9755_reset().
> > > >>>
> > > >>> Reference
> > > >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >>> [1] https://gitlab.com/VictorShih/linux-uhs2.git
> > > >>> [2] SD Host Controller Simplified Specification 4.20
> > > >>> [3] UHS-II Simplified Addendum 1.02
> > > >>> [4] https://patchwork.kernel.org/project/linux-mmc/cover/20230331=
105546.13607-1-victor.shih@genesyslogic.com.tw/
> > > >>>
> > > >>> ----------------- original cover letter from v7 -----------------
> > > >>> Summary
> > > >>> =3D=3D=3D=3D=3D=3D=3D
> > > >>> These patches[1] support UHS-II and fix GL9755 UHS-II compatibili=
ty.
> > > >>>
> > > >>> About UHS-II, roughly deal with the following three parts:
> > > >>> 1) A UHS-II detection and initialization:
> > > >>> - Host setup to support UHS-II (Section 3.13.1 Host Controller Se=
tup Sequence
> > > >>>   [2]).
> > > >>> - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Se=
quence[2]).
> > > >>> - In step(9) of Section 3.13.2 in [2], UHS-II initialization is i=
nclude Section
> > > >>>   3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II Set=
ting Register
> > > >>>   Setup Sequence.
> > > >>>
> > > >>> 2) Send Legacy SD command through SD-TRAN
> > > >>> - Encapsulated SD packets are defined in SD-TRAN in order to ensu=
re Legacy SD
> > > >>>   compatibility and preserve Legacy SD infrastructures (Section 7=
.1.1 Packet
> > > >>>   Types and Format Overview[3]).
> > > >>> - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.=
5 UHS-II
> > > >>>   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issui=
ng[2]).
> > > >>>
> > > >>> 3) UHS-II Interrupt
> > > >>> - Except for UHS-II error interrupts, most interrupts share the o=
riginal
> > > >>>   interrupt registers.
> > > >>>
> > > >>> Patch structure
> > > >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >>> patch#1-#6:  for core
> > > >>> patch#7-#22: for sdhci
> > > >>> patch#23:    for GL9755
> > > >>>
> > > >>> Changes in v7 (Mar. 31, 2023)
> > > >>> * rebased to the linux-kernel-v6.3.0-rc3 in Ulf Hansson next bran=
ch.
> > > >>> * according to the guidance and overall architecture provided
> > > >>>   by Ulf Hansson, Ben Chuang and Jason Lai to implement the
> > > >>>   UHS-2 Core function based on the patches of the [V4,0/6]
> > > >>>   Preparations to support SD UHS-II cards[5].
> > > >>> * according to the guidance and comments provided by
> > > >>>   Adrian Hunter, Ben Chuang and AKASHI Takahiro to implement
> > > >>>   the UHS-2 Host function based on the patches of the
> > > >>>   [RFC,v3.1,00/27] Add support UHS-II for GL9755[4].
> > > >>> * implement the necessary function to let the UHS-2 Core/Host
> > > >>>   work properly.
> > > >>> * fix most of checkpatch warnings/errors.
> > > >>> * according to the guidance and comments provided by
> > > >>>   Adrian Hunter, Ben Chuang to implement the UHS-2
> > > >>>   Host function based on the patches of the
> > > >>>   [V5,00/26] Add support UHS-II for GL9755[6].
> > > >>> * according to the guidance and comments provided by
> > > >>>   Ulf Hanssion, Adrian Hunter, Ben Chuang to implement the UHS-2
> > > >>>   Host function based on the patches of the
> > > >>>   [V6,00/24] Add support UHS-II for GL9755[7].
> > > >>> * The uhs2_post_attach_sd() function is no longer needed so drop
> > > >>>   the V6 version of the Patch#22.
> > > >>> * Modifies the usage of the flags used by the sdhci host for
> > > >>>   MMC_UHS2_INITIALIZED.
> > > >>> * Patch#1: Drop unnecessary bracket.
> > > >>> * Patch#2: Drop sd_uhs2_set_ios function.
> > > >>>            Used ->uhs2_control() callback for uhs2_set_ios
> > > >>>            in sd_uhs2_power_up().
> > > >>>            Used ->uhs2_control() callback for uhs2_set_ios
> > > >>>            in sd_uhs2_power_off().
> > > >>>            Drop MMC_TIMING_SD_UHS2 in favor of MMC_TIMING_UHS2_SP=
EED_A.
> > > >>>            Modify sd_uhs2_legacy_init to avoid the
> > > >>>            sd_uhs2_reinit cycle issue.
> > > >>> * Patch#5: Drop unnecessary definitions.
> > > >>> * Patch#6: Drop unnecessary function.
> > > >>>            Drop uhs2_state in favor of ios->timing.
> > > >>> * Patch#7: Reorder values and positions of definitions.
> > > >>> * Patch#9: Used sdhci_uhs2_mode function to simplify.
> > > >>> * Patch#11: Drop pwr variable in sdhci_uhs2_set_power function.
> > > >>> * Patch#14: Modify some descriptions.
> > > >>>             Drop unnecessary function.
> > > >>> * Patch#15: Drop using uhs2_reset ops and use sdhci_uhs2_reset fu=
nction
> > > >>>             in the sdhci_do_detect_init function.
> > > >>> * Patch#17: Drop unnecessary function.
> > > >>> * Patch#18: Drop unnecessary whitespace changes.
> > > >>>             Cancel the export state of some functions.
> > > >>> * Patch#19: Drop unnecessary function.
> > > >>>             Used sdhci_uhs2_mode function to simplify.
> > > >>>             Modify some descriptions.
> > > >>>             Cancel the export state of some functions.
> > > >>> * Patch#20: Drop using __sdhci_uhs2_host function and use
> > > >>>             __sdhci_add_host function in sdhci_uhs2_add_host func=
tion.
> > > >>>             Cancel the export state of some functions.
> > > >>> * Patch#23: Drop using uhs2_post_attach_sd function.
> > > >>>
> > > >>> Reference
> > > >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >>> [1] https://gitlab.com/ben.chuang/linux-uhs2-gl9755.git
> > > >>> [2] SD Host Controller Simplified Specification 4.20
> > > >>> [3] UHS-II Simplified Addendum 1.02
> > > >>> [4] https://patchwork.kernel.org/project/linux-mmc/cover/20201106=
022726.19831-1-takahiro.akashi@linaro.org/
> > > >>> [5] https://patchwork.kernel.org/project/linux-mmc/cover/20220418=
115833.10738-1-jasonlai.genesyslogic@gmail.com/
> > > >>> [6] https://patchwork.kernel.org/project/linux-mmc/cover/20221019=
110647.11076-1-victor.shih@genesyslogic.com.tw/
> > > >>> [7] https://patchwork.kernel.org/project/linux-mmc/cover/20221213=
090047.3805-1-victor.shih@genesyslogic.com.tw/
> > > >>>
> > > >>> ----------------- original cover letter from v6 -----------------
> > > >>> Summary
> > > >>> =3D=3D=3D=3D=3D=3D=3D
> > > >>> These patches[1] support UHS-II and fix GL9755 UHS-II compatibili=
ty.
> > > >>>
> > > >>> About UHS-II, roughly deal with the following three parts:
> > > >>> 1) A UHS-II detection and initialization:
> > > >>> - Host setup to support UHS-II (Section 3.13.1 Host Controller Se=
tup Sequence
> > > >>>   [2]).
> > > >>> - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Se=
quence[2]).
> > > >>> - In step(9) of Section 3.13.2 in [2], UHS-II initialization is i=
nclude Section
> > > >>>   3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II Set=
ting Register
> > > >>>   Setup Sequence.
> > > >>>
> > > >>> 2) Send Legacy SD command through SD-TRAN
> > > >>> - Encapsulated SD packets are defined in SD-TRAN in order to ensu=
re Legacy SD
> > > >>>   compatibility and preserve Legacy SD infrastructures (Section 7=
.1.1 Packet
> > > >>>   Types and Format Overview[3]).
> > > >>> - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.=
5 UHS-II
> > > >>>   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issui=
ng[2]).
> > > >>>
> > > >>> 3) UHS-II Interrupt
> > > >>> - Except for UHS-II error interrupts, most interrupts share the o=
riginal
> > > >>>   interrupt registers.
> > > >>>
> > > >>> Patch structure
> > > >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >>> patch#1-#6:  for core
> > > >>> patch#7-#23: for sdhci
> > > >>> patch#24:    for GL9755
> > > >>>
> > > >>> Changes in v6 (Dec. 12, 2022)
> > > >>> * rebased to the linux-kernel-v6.1.0-rc8 in Ulf Hansson next bran=
ch.
> > > >>> * according to the guidance and overall architecture provided
> > > >>>   by Ulf Hansson, Ben Chuang and Jason Lai to implement the
> > > >>>   UHS-2 Core function based on the patches of the [V4,0/6]
> > > >>>   Preparations to support SD UHS-II cards[5].
> > > >>> * according to the guidance and comments provided by
> > > >>>   Adrian Hunter, Ben Chuang and AKASHI Takahiro to implement
> > > >>>   the UHS-2 Host function based on the patches of the
> > > >>>   [RFC,v3.1,00/27] Add support UHS-II for GL9755[4].
> > > >>> * implement the necessary function to let the UHS-2 Core/Host
> > > >>>   work properly.
> > > >>> * fix most of checkpatch warnings/errors.
> > > >>> * according to the guidance and comments provided by
> > > >>>   Adrian Hunter, Ben Chuang to implement the UHS-2
> > > >>>   Host function based on the patches of the
> > > >>>   [V5,00/26] Add support UHS-II for GL9755[6].
> > > >>> * The uhs2_post_attach_sd() has implemented in Patch#6 and
> > > >>>   Patch#17 so drop the V5 version of the Patch#23.
> > > >>> * Modifies the usage of the flags used by the sdhci host for
> > > >>>   MMC_UHS2_INITIALIZED.
> > > >>> * Patch#5: Drop unused definitions and functions.
> > > >>> * Patch#7: Rename definitions.
> > > >>>            Use BIT() GENMASK() in some cases.
> > > >>> * Patch#8: Merge V5 version of Patch[7] and Patch[9] into
> > > >>>            V6 version of Patch[8].
> > > >>> * Patch#9: Drop unnecessary function.
> > > >>>            Rename used definitions.
> > > >>> * Patch#10: Drop unnecessary function and simplify some code.
> > > >>> * Patch#11: Drop unnecessary function.
> > > >>>             Add new mmc_opt_regulator_set_ocr function.
> > > >>> * Patch#13: Drop unnecessary function.
> > > >>>             Use GENMASK() and FIELD_PREP() in some cases.
> > > >>> * Patch#14: Drop unnecessary function.
> > > >>>             Modify return value in some function.
> > > >>>             Use GENMASK() and FIELD_PREP() in some cases.
> > > >>> * Patch#15: Drop unnecessary function.
> > > >>>             Rename used definitions.
> > > >>>             Use GENMASK() and FIELD_GET() in some cases.
> > > >>>             Wrap at 100 columns in some functions.
> > > >>> * Patch#16: Drop unnecessary function.
> > > >>> * Patch#17: Drop unnecessary function.
> > > >>>             Drop the unnecessary parameter when call the DBG()
> > > >>>             function.
> > > >>>             Rename used definitions.
> > > >>>             Cancel the export state of some functions.
> > > >>>             Use GENMASK() and FIELD_PREP() in some cases.
> > > >>> * Patch#18: Drop unnecessary function.
> > > >>>             Add uhs2_dev_cmd function to simplify some functions.
> > > >>>             Rename used definitions.
> > > >>>             Cancel the export state of some functions.
> > > >>>             Use GENMASK() and FIELD_PREP() in some cases.
> > > >>> * Patch#19: Drop unnecessary function.
> > > >>>             Add sdhci_uhs2_mode() in some functions.
> > > >>>             Rename used definitions.
> > > >>>             Cancel the export state of some functions.
> > > >>> * Patch#20: Add new complete_work_fn/thread_irq_fn variables in
> > > >>>             struct sdhci_host.
> > > >>>             Use complete_work_fn/thread_irq_fn variables in
> > > >>>             sdhci_alloc_host()/sdhci_uhs2_add_host().
> > > >>>             Rename used definitions.
> > > >>> * Patch[24]: Rename used definitions.
> > > >>>
> > > >>> Reference
> > > >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >>> [1] https://gitlab.com/ben.chuang/linux-uhs2-gl9755.git
> > > >>> [2] SD Host Controller Simplified Specification 4.20
> > > >>> [3] UHS-II Simplified Addendum 1.02
> > > >>> [4] https://patchwork.kernel.org/project/linux-mmc/cover/20201106=
022726.19831-1-takahiro.akashi@linaro.org/
> > > >>> [5] https://patchwork.kernel.org/project/linux-mmc/cover/20220418=
115833.10738-1-jasonlai.genesyslogic@gmail.com/
> > > >>> [6] https://patchwork.kernel.org/project/linux-mmc/cover/20221019=
110647.11076-1-victor.shih@genesyslogic.com.tw/
> > > >>>
> > > >>> ----------------- original cover letter from v5 -----------------
> > > >>> Summary
> > > >>> =3D=3D=3D=3D=3D=3D=3D
> > > >>> These patches[1] support UHS-II and fix GL9755 UHS-II compatibili=
ty.
> > > >>>
> > > >>> About UHS-II, roughly deal with the following three parts:
> > > >>> 1) A UHS-II detection and initialization:
> > > >>> - Host setup to support UHS-II (Section 3.13.1 Host Controller Se=
tup Sequence
> > > >>>   [2]).
> > > >>> - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Se=
quence[2]).
> > > >>> - In step(9) of Section 3.13.2 in [2], UHS-II initialization is i=
nclude Section
> > > >>>   3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II Set=
ting Register
> > > >>>   Setup Sequence.
> > > >>>
> > > >>> 2) Send Legacy SD command through SD-TRAN
> > > >>> - Encapsulated SD packets are defined in SD-TRAN in order to ensu=
re Legacy SD
> > > >>>   compatibility and preserve Legacy SD infrastructures (Section 7=
.1.1 Packet
> > > >>>   Types and Format Overview[3]).
> > > >>> - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.=
5 UHS-II
> > > >>>   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issui=
ng[2]).
> > > >>>
> > > >>> 3) UHS-II Interrupt
> > > >>> - Except for UHS-II error interrupts, most interrupts share the o=
riginal
> > > >>>   interrupt registers.
> > > >>>
> > > >>> Patch structure
> > > >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >>> patch#1-#6:  for core
> > > >>> patch#7-#25: for sdhci
> > > >>> patch#26:    for GL9755
> > > >>>
> > > >>> Changes in v5 (Oct. 19, 2022)
> > > >>> * rebased to the linux-kernel-v6.1-rc1 in Ulf Hansson next branch=
.
> > > >>> * according to the guidance and overall architecture provided
> > > >>>   by Ulf Hansson, Ben Chuang and Jason Lai to implement the
> > > >>>   UHS-2 Core function based on the patches of the [V4,0/6]
> > > >>>   Preparations to support SD UHS-II cards[5].
> > > >>> * according to the guidance and comments provided by
> > > >>>   Adrian Hunter, Ben Chuang and AKASHI Takahiro to implement
> > > >>>   the UHS-2 Host function based on the patches of the
> > > >>>   [RFC,v3.1,00/27] Add support UHS-II for GL9755[4].
> > > >>> * implement the necessary function to let the UHS-2 Core/Host
> > > >>>   work properly.
> > > >>> * fix most of checkpatch warnings/errors
> > > >>>
> > > >>> Reference
> > > >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >>> [1] https://gitlab.com/ben.chuang/linux-uhs2-gl9755.git
> > > >>> [2] SD Host Controller Simplified Specification 4.20
> > > >>> [3] UHS-II Simplified Addendum 1.02
> > > >>> [4] https://patchwork.kernel.org/project/linux-mmc/cover/20201106=
022726.19831-1-takahiro.akashi@linaro.org/
> > > >>> [5] https://patchwork.kernel.org/project/linux-mmc/cover/20220418=
115833.10738-1-jasonlai.genesyslogic@gmail.com/
> > > >>>
> > > >>> ----------------- original cover letter from v3.1 ---------------=
--
> > > >>> This is an interim snapshot of our next version, v4, for enabling
> > > >>> UHS-II on MMC/SD.
> > > >>>
> > > >>> It is focused on 'sdhci' side to address Adrian's comments regard=
ing
> > > >>> "modularising" sdhci-uhs2.c.
> > > >>> The whole aim of this version is to get early feedback from Adria=
n (and
> > > >>> others) on this issue. Without any consensus about the code struc=
ture,
> > > >>> it would make little sense to go further ahead on sdhci side.
> > > >>> (Actually, Adrian has made no comments other than "modularising" =
so far.)
> > > >>>
> > > >>> I heavily reworked/refactored sdhci-uhs2.c and re-organised the p=
atch
> > > >>> set to meet what I believe Adrian expects; no UHS-II related code=
 in
> > > >>> Legacy (UHS-I) code or sdhci.c.
> > > >>>
> > > >>> Nevertheless, almost of all changes I made are trivial and straig=
htforward
> > > >>> in this direction, and I believe that there is no logic changed s=
ince v3
> > > >>> except sdhci_uhs2_irq(), as ops->irq hook, where we must deal wit=
h UHS-II
> > > >>> command sequences in addition to UHS-II errors. So I added extra =
handlings.
> > > >>>
> > > >>> I admit that there is plenty of room for improvements (for exampl=
e,
> > > >>> handling host->flags), but again the focal point here is how sdhc=
i-uhs2.c
> > > >>> should be built as a module.
> > > >>>
> > > >>> Please review this series (particularly Patch#8-#26 and #27) from=
 this
> > > >>> viewpoint in the first place.
> > > >>> (Ben is working on 'host' side but there is no change on 'host' s=
ide
> > > >>> in this submission except a minor tweak.)
> > > >>>
> > > >>> Thanks,
> > > >>> -Takahiro Akashi
> > > >>>
> > > >>> ------ original cover letter from v3 ------
> > > >>> Summary
> > > >>> =3D=3D=3D=3D=3D=3D=3D
> > > >>> These patches[1] support UHS-II and fix GL9755 UHS-II compatibili=
ty.
> > > >>>
> > > >>> About UHS-II, roughly deal with the following three parts:
> > > >>> 1) A UHS-II detection and initialization:
> > > >>> - Host setup to support UHS-II (Section 3.13.1 Host Controller Se=
tup Sequence
> > > >>>   [2]).
> > > >>> - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Se=
quence[2]).
> > > >>> - In step(9) of Section 3.13.2 in [2], UHS-II initialization is i=
nclude Section
> > > >>>   3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II Set=
ting Register
> > > >>>   Setup Sequence.
> > > >>>
> > > >>> 2) Send Legacy SD command through SD-TRAN
> > > >>> - Encapsulated SD packets are defined in SD-TRAN in order to ensu=
re Legacy SD
> > > >>>   compatibility and preserve Legacy SD infrastructures (Section 7=
.1.1 Packet
> > > >>>   Types and Format Overview[3]).
> > > >>> - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.=
5 UHS-II
> > > >>>   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issui=
ng[2]).
> > > >>>
> > > >>> 3) UHS-II Interrupt
> > > >>> - Except for UHS-II error interrupts, most interrupts share the o=
riginal
> > > >>>   interrupt registers.
> > > >>>
> > > >>> Patch structure
> > > >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >>> patch#1-#7: for core
> > > >>> patch#8-#17: for sdhci
> > > >>> patch#18-#21: for GL9755
> > > >>>
> > > >>> Tests
> > > >>> =3D=3D=3D=3D=3D
> > > >>> Ran 'dd' command to evaluate the performance:
> > > >>> (SanDisk UHS-II card on GL9755 controller)
> > > >>>                              Read    Write
> > > >>> UHS-II disabled (UHS-I): 88.3MB/s 60.7MB/s
> > > >>> UHS-II enabled         :  206MB/s   80MB/s
> > > >>>
> > > >>> TODO
> > > >>> =3D=3D=3D=3D
> > > >>> - replace some define with BIT macro
> > > >>>
> > > >>> Reference
> > > >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >>> [1] https://gitlab.com/ben.chuang/linux-uhs2-gl9755.git
> > > >>> [2] SD Host Controller Simplified Specification 4.20
> > > >>> [3] UHS-II Simplified Addendum 1.02
> > > >>>
> > > >>> Changes in v3 (Jul. 10, 2020)
> > > >>> * rebased to v5.8-rc4
> > > >>> * add copyright notice
> > > >>> * reorganize the patch set and split some commits into smaller on=
es
> > > >>> * separate uhs-2 headers from others
> > > >>> * correct wrong spellings
> > > >>> * fix most of checkpatch warnings/errors
> > > >>> * remove all k[cz]alloc() from the code
> > > >>> * guard sdhci-uhs2 specific code with
> > > >>>       'if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2))'
> > > >>> * make sdhci-uhs2.c as a module
> > > >>> * trivial changes, including
> > > >>>   - rename back sdhci-core.c to sdhci.c
> > > >>>   - allow vendor code to disable uhs2 if v4_mode =3D=3D 0
> > > >>>       in __sdhci_add_host()
> > > >>>   - merge uhs2_power_up() into mmc_power_up()
> > > >>>   - remove flag_uhs2 from mmc_attach_sd()
> > > >>>   - add function descriptions to EXPORT'ed functions
> > > >>>   - other minor code optimization
> > > >>>
> > > >>> Changes in v2 (Jan. 9, 2020)
> > > >>> * rebased to v5.5-rc5
> > > >>>
> > > >>> Ben Chuang (1):
> > > >>>   mmc: sdhci-uhs2: add pre-detect_init hook
> > > >>>
> > > >>> Ulf Hansson (4):
> > > >>>   mmc: core: Cleanup printing of speed mode at card insertion
> > > >>>   mmc: core: Prepare to support SD UHS-II cards
> > > >>>   mmc: core: Announce successful insertion of an SD UHS-II card
> > > >>>   mmc: core: Extend support for mmc regulators with a vqmmc2
> > > >>>
> > > >>> Victor Shih (17):
> > > >>>   mmc: core: Add definitions for SD UHS-II cards
> > > >>>   mmc: core: Add New function to re-factoring the code
> > > >>>   mmc: core: Support UHS-II card control and access
> > > >>>   mmc: sdhci: add UHS-II related definitions in headers
> > > >>>   mmc: sdhci: add UHS-II module and add a kernel configuration
> > > >>>   mmc: sdhci-uhs2: dump UHS-II registers
> > > >>>   mmc: sdhci-uhs2: add reset function
> > > >>>   mmc: sdhci-uhs2: add set_power() to support vdd2
> > > >>>   mmc: sdhci-uhs2: add set_timeout()
> > > >>>   mmc: sdhci-uhs2: add set_ios()
> > > >>>   mmc: sdhci-uhs2: add uhs2_control() to initialise the interface
> > > >>>   mmc: sdhci-uhs2: add request() and others
> > > >>>   mmc: sdhci-uhs2: add irq() and others
> > > >>>   mmc: sdhci-uhs2: add add_host() and others to set up the driver
> > > >>>   mmc: sdhci-pci: add UHS-II support framework
> > > >>>   mmc: sdhci-pci-gli: enable UHS-II mode for GL9755
> > > >>>   mmc: sdhci-pci-gli: enable UHS-II mode for GL9767
> > > >>>
> > > >>>  drivers/mmc/core/Makefile         |    2 +-
> > > >>>  drivers/mmc/core/bus.c            |   38 +-
> > > >>>  drivers/mmc/core/core.c           |   23 +-
> > > >>>  drivers/mmc/core/core.h           |    1 +
> > > >>>  drivers/mmc/core/mmc_ops.c        |   24 +-
> > > >>>  drivers/mmc/core/mmc_ops.h        |    1 +
> > > >>>  drivers/mmc/core/regulator.c      |   34 +
> > > >>>  drivers/mmc/core/sd.c             |   10 +-
> > > >>>  drivers/mmc/core/sd.h             |    5 +
> > > >>>  drivers/mmc/core/sd_ops.c         |    9 +
> > > >>>  drivers/mmc/core/sd_ops.h         |   13 +
> > > >>>  drivers/mmc/core/sd_uhs2.c        | 1326 +++++++++++++++++++++++=
++++++
> > > >>>  drivers/mmc/host/Kconfig          |   10 +
> > > >>>  drivers/mmc/host/Makefile         |    1 +
> > > >>>  drivers/mmc/host/sdhci-pci-core.c |   16 +-
> > > >>>  drivers/mmc/host/sdhci-pci-gli.c  |  446 +++++++++-
> > > >>>  drivers/mmc/host/sdhci-pci.h      |    3 +
> > > >>>  drivers/mmc/host/sdhci-uhs2.c     | 1272 +++++++++++++++++++++++=
++++
> > > >>>  drivers/mmc/host/sdhci-uhs2.h     |  190 +++++
> > > >>>  drivers/mmc/host/sdhci.c          |  281 +++---
> > > >>>  drivers/mmc/host/sdhci.h          |   75 +-
> > > >>>  include/linux/mmc/card.h          |   36 +
> > > >>>  include/linux/mmc/core.h          |   17 +
> > > >>>  include/linux/mmc/host.h          |   80 ++
> > > >>>  include/linux/mmc/sd_uhs2.h       |  240 ++++++
> > > >>>  25 files changed, 4003 insertions(+), 150 deletions(-)
> > > >>>  create mode 100644 drivers/mmc/core/sd_uhs2.c
> > > >>>  create mode 100644 drivers/mmc/host/sdhci-uhs2.c
> > > >>>  create mode 100644 drivers/mmc/host/sdhci-uhs2.h
> > > >>>  create mode 100644 include/linux/mmc/sd_uhs2.h
> > > >>>
> > > >>> --
> > > >>> 2.25.1
> > > >>>
> > >

