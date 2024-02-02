Return-Path: <linux-mmc+bounces-836-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7694C846E31
	for <lists+linux-mmc@lfdr.de>; Fri,  2 Feb 2024 11:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8067B1C22E01
	for <lists+linux-mmc@lfdr.de>; Fri,  2 Feb 2024 10:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEA313D4EE;
	Fri,  2 Feb 2024 10:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WyxllP+5"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E9113BEB6
	for <linux-mmc@vger.kernel.org>; Fri,  2 Feb 2024 10:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706870790; cv=none; b=qw9VUex4oN0kLe2bs81XISHXKxS2GXiCLZ9vmKxwa0BP6AREv5CFN0GgGn5bjlIGMSlHIUj8uPsJjQmL2j4KlPBvhO5yx928MX2jXCBtk5ILVAQnX+vWndjfhNNl+aCP4iLl2DsLQBvf8BcB2025J2pzCUGLgz29VcNaB5KkylM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706870790; c=relaxed/simple;
	bh=oIT2OQmsLlzS8k1iK5DqvMwab4iQZFquFr3LbXzkkzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hrfu9u6PMP9k3qol0svlMiu6ZaE6IPBTlHo62Au4cI2DK9M0/LAaQD2h98bDLjjggUAtQ5sNXmIgiDHQ32IKPP/6Q7JpwoRFOCVql8/Os/VGhIHgH39DMsIa39vPV9ubUA4/5LklZG+qZZk5rOInkCTuObsO0YV5hjcjVs6ex88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WyxllP+5; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-59a27fbe832so889504eaf.3
        for <linux-mmc@vger.kernel.org>; Fri, 02 Feb 2024 02:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706870786; x=1707475586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRi3pn+DeYpH9hRBU3X4kEEe9FeJxU463/du/+mtcAM=;
        b=WyxllP+5AzUGW4RxRLQ2i298pl6lNUw2AxUgJCaxYaK4slCTxt2epHvMF901cEJvwP
         KhGSONQqupBqWAsrvtKRoX/FNQy+Rz+pEGT1lULzJ2pwytQxE9hwyo13/ZDgyvSonuYc
         gjUG94xR+jK6MT/GziQqRt2iJcMx78qAMysE72Q5l80k6dGs+7qeJm2d38zuIWDhnZW4
         8eWfKkn8wSSxAQjdSR8miJuYyfUn3RmbRq0+BgoAOTZCc/vo66Ziu3wzke2m98nPFY5N
         /nG6RGXkaUzJl6bcWut9udiUAMqEyTXU9Y40LWCr/UPvq6WBj7HSkLnNmF+KCKuVTcmd
         qZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706870786; x=1707475586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BRi3pn+DeYpH9hRBU3X4kEEe9FeJxU463/du/+mtcAM=;
        b=rymnSryvrORc6kSKD+7FgMRkAwxqr0fyHEpdGM7NYp77FRsQK9+RgEJy2JcaP9PHji
         sBw0+Z8sQPIPy3uERFHH8dsznYAi/igARMUqVxrpme3464H8idFRs5GsHgbHBcNnkTZp
         jpepfDCcLIMe0H8rxtUMAqPoMSkx/WCEYA/9zM1opANI7fb1LBO+EtGbHJ6ZUQbkESGb
         hiDFod+QOz+WsqV9WwIIOs/P3lYF0C4gbeDTkQVJmuKNOTorizB8cileHAOSpZTvZigZ
         uFnQmbB1DbGB72pHboRMbDkfIfFmDorIvuHdgJh/uWB3vVrPE9ruBxmjpnKTdPLaskLQ
         mb6A==
X-Gm-Message-State: AOJu0YyoRl8Guqlm+iTJ+2BFlfBIWIMTkW3SvfNcrDVlVwKoMCc/u9N/
	3CFGYb+VKL7Z6t+U8Zf9wUVkkav2FjgMRPFLo4OfoogIRuagfTNJuIwW+/7J1e80wGlgzYhuqXe
	7ARJZ8rmcR6bJIeTdXsFPXat0+ZsC/Tr7gRXIkQ==
X-Google-Smtp-Source: AGHT+IEuTMbdIOzteufxZXeY/IYZgUAQuVpfuGo670XZGtUWRuASG9h19SSHfjhm84ZBYQ23pZPMGc4BnsnrM4x0w+I=
X-Received: by 2002:a05:6820:22aa:b0:59a:1947:d3ec with SMTP id
 ck42-20020a05682022aa00b0059a1947d3ecmr6495658oob.5.1706870786631; Fri, 02
 Feb 2024 02:46:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131174347.510961-1-jens.wiklander@linaro.org> <CAFA6WYORTtuRsoiDhjCdPwaDHyJ+ixZBu_-VQHPE2RhCprKQ0w@mail.gmail.com>
In-Reply-To: <CAFA6WYORTtuRsoiDhjCdPwaDHyJ+ixZBu_-VQHPE2RhCprKQ0w@mail.gmail.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Fri, 2 Feb 2024 11:46:15 +0100
Message-ID: <CAHUa44FmrtsbssK_R_Pm9WLzrSPU++HOETfaVxHqoZyhSEM8jw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Replay Protected Memory Block (RPMB) subsystem
To: Sumit Garg <sumit.garg@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Jerome Forissier <jerome.forissier@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bart Van Assche <bvanassche@acm.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sumit,

On Fri, Feb 2, 2024 at 10:59=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org> =
wrote:
>
> Hi Jens,
>
> On Wed, 31 Jan 2024 at 23:14, Jens Wiklander <jens.wiklander@linaro.org> =
wrote:
> >
> > Hi,
> >
> > It's been a while since Shyam posted the last version [1] of this patch
> > set. I've pinged Shyam, but so far I've had no reply so I'm trying to m=
ake
> > another attempt with the RPMB subsystem. If Shyam has other changes in =
mind
> > than what I'm adding here I hope we'll find a way to cover that too. I'=
m
> > calling it version two of the patchset since I'm trying to address all
> > feedback on the previous version even if I'm starting a new thread.
> >
> > This patch set introduces a new RPMB subsystem, based on patches from [=
1],
> > [2], and [3]. The RPMB subsystem aims at providing access to RPMB
> > partitions to other kernel drivers, in particular the OP-TEE driver. A =
new
> > user space ABI isn't needed, we can instead continue using the already
> > present ABI when writing the RPMB key during production.
> >
> > I've added and removed things to keep only what is needed by the OP-TEE
> > driver. Since the posting of [3], there has been major changes in the M=
MC
> > subsystem so "mmc: block: register RPMB partition with the RPMB subsyst=
em"
> > is in practice completely rewritten.
> >
> > With this OP-TEE can access RPMB during early boot instead of having to
> > wait for user space to become available as in the current design [4].
> > This will benefit the efi variables [5] since we wont rely on userspace=
 as
> > well as some TPM issues [6] that were solved.
> >
> > The OP-TEE driver finds the correct RPMB device to interact with by
> > iterating over available devices until one is found with a programmed
> > authentication matching the one OP-TEE is using. This enables coexistin=
g
> > users of other RPMBs since the owner can be determined by who knows the
> > authentication key.
> >
> > I've put myself as a maintainer for the RPMB subsystem as I have an
> > interest in the OP-TEE driver to keep this in good shape. However, if y=
ou'd
> > rather see someone else taking the maintainership that's fine too. I'll
> > help keep the subsystem updated regardless.
> >
> > [1] https://lore.kernel.org/lkml/20230722014037.42647-1-shyamsaini@linu=
x.microsoft.com/
> > [2] https://lore.kernel.org/lkml/20220405093759.1126835-2-alex.bennee@l=
inaro.org/
> > [3] https://lore.kernel.org/linux-mmc/1478548394-8184-2-git-send-email-=
tomas.winkler@intel.com/
> > [4] https://optee.readthedocs.io/en/latest/architecture/secure_storage.=
html#rpmb-secure-storage
> > [5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3Dc44b6be62e8dd4ee0a308c36a70620613e6fc55f
> > [6] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3D7269cba53d906cf257c139d3b3a53ad272176bca
> >
> > Thanks,
> > Jens
> >
> > Changes since Shyam's RFC:
> > * Removed the remaining leftover rpmb_cdev_*() function calls
> > * Refactored the struct rpmb_ops with all the previous ops replaced, in
> >   some sense closer to [3] with the route_frames() op
> > * Added rpmb_route_frames()
> > * Added struct rpmb_frame, enum rpmb_op_result, and enum rpmb_type from=
 [3]
> > * Removed all functions not needed in the OP-TEE use case
> > * Added "mmc: block: register RPMB partition with the RPMB subsystem", =
based
> >   on the commit with the same name in [3]
> > * Added "optee: probe RPMB device using RPMB subsystem" for integration
> >   with OP-TEE
> > * Moved the RPMB driver into drivers/misc/rpmb-core.c
> > * Added my name to MODULE_AUTHOR() in rpmb-core.c
> > * Added an rpmb_mutex to serialize access to the IDA
> > * Removed the target parameter from all rpmb_*() functions since it's
> >   currently unused
> >
>
> Thanks for working on this. This is a huge step towards supporting TEE
> kernel client drivers. IIRC you mentioned offline to test it with
> virtio RPMB on Qemu. If it works then I would be happy to try it out
> as well.

I'm sorry, I didn't get far enough with that. I've been testing on a
HiKey 620 with a removable HardKernel eMMC. So I have two RPMBs to
test with.

>
> Along with that can you point me to the corresponding OP-TEE OS
> changes? I suppose as you are just adding 3 new RPC calls in patch#3,
> so we should be fine ABI wise although people have to uprev both
> OP-TEE and Linux kernel to get this feature enabled. However, OP-TEE
> should gate those RPCs behind a config flag or can just fallback to
> user-space supplicant if those aren't supported?

Here are the OP-TEE OS patches
https://github.com/jenswi-linaro/optee_os/tree/rpmb_probe .
Yes, there's automatic fallback to the user-space supplicant if the
kernel reports that the new RPCs aren't supported and the kernel will
not use the in-kernel driver unless the new RPCs have been used.

Cheers,
Jens

>
> -Sumit
>
> >
> >
> > Jens Wiklander (3):
> >   rpmb: add Replay Protected Memory Block (RPMB) subsystem
> >   mmc: block: register RPMB partition with the RPMB subsystem
> >   optee: probe RPMB device using RPMB subsystem
> >
> >  MAINTAINERS                       |   7 +
> >  drivers/misc/Kconfig              |   9 ++
> >  drivers/misc/Makefile             |   1 +
> >  drivers/misc/rpmb-core.c          | 247 ++++++++++++++++++++++++++++++
> >  drivers/mmc/core/block.c          | 177 +++++++++++++++++++++
> >  drivers/tee/optee/core.c          |   1 +
> >  drivers/tee/optee/ffa_abi.c       |   2 +
> >  drivers/tee/optee/optee_private.h |   6 +
> >  drivers/tee/optee/optee_rpc_cmd.h |  33 ++++
> >  drivers/tee/optee/rpc.c           | 221 ++++++++++++++++++++++++++
> >  drivers/tee/optee/smc_abi.c       |   2 +
> >  include/linux/rpmb.h              | 184 ++++++++++++++++++++++
> >  12 files changed, 890 insertions(+)
> >  create mode 100644 drivers/misc/rpmb-core.c
> >  create mode 100644 include/linux/rpmb.h
> >
> >
> > base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3
> > --
> > 2.34.1
> >

