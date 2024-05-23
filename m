Return-Path: <linux-mmc+bounces-2157-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A04D38CCE7B
	for <lists+linux-mmc@lfdr.de>; Thu, 23 May 2024 10:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15662B2220F
	for <lists+linux-mmc@lfdr.de>; Thu, 23 May 2024 08:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA89414A4DE;
	Thu, 23 May 2024 08:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mecka.net header.i=@mecka.net header.b="rCCkBsW6"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mecka.net (mecka.net [159.69.159.214])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6FD146A8F;
	Thu, 23 May 2024 08:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.159.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716453784; cv=none; b=uEv+oNTrAD979JWBSrK4mROOSA5OasT8B+2jQnqealxqTrNXdEoc3G5qdnrAl7Ph1fmKvYIRBAypp87Ed8id6+E6wV9OS6rhTHu0GBOz2MJQXMUVSVlh6tZSDEzG57nVOSnfV8nPWjHzTseECDkykhdPWviYdPEUa+zimjCYdkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716453784; c=relaxed/simple;
	bh=AndB0E0r1e9qZgawJdb/LvOmlM892xmlVYziV615hO0=;
	h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WxJyJYF4AoxFbpP6Dp2ROhc50m3RMnv6u2hHCBr2xo+b0UTKQCTLpTMSQXCJfIdUADBcQjDUHBzoBffZSOaFImJyCmuYOvRSluehdpNwi5e3D+5KJmOrMD96b/WsMDn6GsSAOXbS8whrg0k+V5MvkhTFyP3EO14k6BY1vWUYcns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mecka.net; spf=pass smtp.mailfrom=mecka.net; dkim=fail (0-bit key) header.d=mecka.net header.i=@mecka.net header.b=rCCkBsW6 reason="key not found in DNS"; arc=none smtp.client-ip=159.69.159.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mecka.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mecka.net
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mecka.net; s=2016.11;
	t=1716453303; bh=AndB0E0r1e9qZgawJdb/LvOmlM892xmlVYziV615hO0=;
	h=Date:From:Subject:To:Cc:In-Reply-To:References:From;
	b=rCCkBsW6bD1WZR97MA5T/BqM/12IJL4JlmZvHtTlI0/nk9wIxtA2upzxTYTHiq0t9
	 g3OF5XZENcWpONtnpDblymBXz+d376YE7o/CEsYl8vYwLByE5T0lz/tqEYATXQxlDU
	 5f7gIzOJ6RxhBeR85s6pjKU7mCW8sVn6LU7kz468hz0yudWeetFPPWGpG+zfpu5yT8
	 TG3+mBdXwPZq00Ayz3noMLnZDxojWCaDmZFTMPZNG0+RzDVEX+tMILETrWmDlTowWD
	 TxxIA0jLz72OuHYQGcI5ARFkXHS3w6xMoLr2iFsJM/oaPEQIBiv61LLAgvrRTb2XmF
	 xYY26jAqKdK6g==
Received: from [100.123.48.147] (unknown [213.55.227.173])
	by mecka.net (Postfix) with ESMTPSA id 068994E6C67;
	Thu, 23 May 2024 10:35:02 +0200 (CEST)
Date: Thu, 23 May 2024 10:34:56 +0200
From: Manuel Traut <manut@mecka.net>
Subject: Re: [PATCH v6 0/3] Replay Protected Memory Block (RPMB) subsystem
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	op-tee@lists.trustedfirmware.org, Shyam Saini
	<shyamsaini@linux.microsoft.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>, Jerome Forissier
	<jerome.forissier@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bart Van Assche
	<bvanassche@acm.org>, Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel
	<ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
Message-Id: <8UJXDS.UATQJMAP9FTR@mecka.net>
In-Reply-To: <CAHUa44GFd0-jB7VV2=iL0YWT9+NyY+jDZNdxpERGWODO08pFDA@mail.gmail.com>
References: <20240507091619.2208810-1-jens.wiklander@linaro.org>
	<ZkODCTnCe7l0KiFs@mecka.net>
	<CAHUa44GFd0-jB7VV2=iL0YWT9+NyY+jDZNdxpERGWODO08pFDA@mail.gmail.com>
X-Mailer: geary/44.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Jens,

On Wed, May 22 2024 at 17:33:07 +02:00:00, Jens Wiklander=20
<jens.wiklander@linaro.org> wrote:
> Hi Manuel,
>=20
> On Tue, May 14, 2024 at 5:28=E2=80=AFPM Manuel Traut <manut@mecka.net>=20
> wrote:
>>=20
>>  Hi Jens,
>>=20
>>  thank you very much for v6! It took me some time to figure out why=20
>> it is
>>  not working.. However it seems to be on the OP-TEE side and not=20
>> related
>>  to this kernel series.
>>=20
>>  I need this change:
>>=20
>>  @@ -1214,12 +1225,13 @@ static TEE_Result tee_rpmb_init(void)
>>          }
>>=20
>>          if (rpmb_ctx->reinit) {
>>                  if (rpmb_ctx->legacy_operation ||=20
>> !rpmb_ctx->key_verified) {
>>                          rpmb_ctx->wr_cnt_synced =3D false;
>>                          rpmb_ctx->key_derived =3D false;
>>                          rpmb_ctx->dev_info_synced =3D false;
>>                          rpmb_ctx->reinit =3D false;
>>  -                       goto next;
>>                  }
>>                  res =3D rpmb_probe_reset();
>>                  if (res) {
>>=20
>>  @@ -1236,17 +1248,23 @@ static TEE_Result tee_rpmb_init(void)
>>                          if (!memcmp(rpmb_ctx->cid, dev_info.cid,
>>                                     RPMB_EMMC_CID_SIZE)) {
>>                                  rpmb_ctx->reinit =3D false;
>>  +                               rpmb_ctx->legacy_operation =3D false;
>>                                  return TEE_SUCCESS;
>>                          }
>>                  }
>>          }
>>=20
>>  to ensure that the non legacy mode is selected, even if the first=20
>> RPMB
>>  request comes from a compiled in TA.
>=20
> That patch didn't quite work in my case, but I think I understand
> what's needed at your end.
>=20
> I've prepared patches at https://github.com/OP-TEE/optee_os/pull/6852
> can you try those, please

this also works on my side.

Thanks a lot
Manuel

>>=20
>>  Thanks for your work, it makes it really easy now to implement ARM
>>  System Ready IR with an fTPM and continue the boot measurements in=20
>> the
>>  initrd with the new tpm2.target in systemd v256.
>=20
> Thanks, much appreciated.
>=20
> Cheers,
> Jens
>=20
>>=20
>>  Regards
>>  Manuel
>>=20
>>  On Tue, May 07, 2024 at 11:16:16AM +0200, Jens Wiklander wrote:
>>  > Hi,
>>  >
>>  > This patch set introduces a new RPMB subsystem, based on patches=20
>> from [1],
>>  > [2], and [3]. The RPMB subsystem aims at providing access to RPMB
>>  > partitions to other kernel drivers, in particular the OP-TEE=20
>> driver. A new
>>  > user space ABI isn't needed, we can instead continue using the=20
>> already
>>  > present ABI when writing the RPMB key during production.
>>  >
>>  > I've added and removed things to keep only what is needed by the=20
>> OP-TEE
>>  > driver. Since the posting of [3], there has been major changes in=20
>> the MMC
>>  > subsystem so "mmc: block: register RPMB partition with the RPMB=20
>> subsystem"
>>  > is in practice completely rewritten.
>>  >
>>  > With this OP-TEE can access RPMB during early boot instead of=20
>> having to
>>  > wait for user space to become available as in the current design=20
>> [4].
>>  > This will benefit the efi variables [5] since we wont rely on=20
>> userspace as
>>  > well as some TPM issues [6] that were solved.
>>  >
>>  > The OP-TEE driver finds the correct RPMB device to interact with=20
>> by
>>  > iterating over available devices until one is found with a=20
>> programmed
>>  > authentication matching the one OP-TEE is using. This enables=20
>> coexisting
>>  > users of other RPMBs since the owner can be determined by who=20
>> knows the
>>  > authentication key.
>>  >
>>  > The corresponding secure world OP-TEE patches are available at=20
>> [7].
>>  >
>>  > I've put myself as a maintainer for the RPMB subsystem as I have=20
>> an
>>  > interest in the OP-TEE driver to keep this in good shape.=20
>> However, if you'd
>>  > rather see someone else taking the maintainership that's fine=20
>> too. I'll
>>  > help keep the subsystem updated regardless.
>>  >
>>  > [1]=20
>> https://lore.kernel.org/lkml/20230722014037.42647-1-shyamsaini@linux.mic=
rosoft.com/
>>  > [2]=20
>> https://lore.kernel.org/lkml/20220405093759.1126835-2-alex.bennee@linaro=
.org/
>>  > [3]=20
>> https://lore.kernel.org/linux-mmc/1478548394-8184-2-git-send-email-tomas=
.winkler@intel.com/
>>  > [4]=20
>> https://optee.readthedocs.io/en/latest/architecture/secure_storage.html#=
rpmb-secure-storage
>>  > [5]=20
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi=
t/?id=3Dc44b6be62e8dd4ee0a308c36a70620613e6fc55f
>>  > [6]=20
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi=
t/?id=3D7269cba53d906cf257c139d3b3a53ad272176bca
>>  > [7] https://github.com/jenswi-linaro/optee_os/tree/rpmb_probe_v6
>>  >
>>  > Thanks,
>>  > Jens
>>  >
>>  > Changes since v5:
>>  > Manuel Traut reported and investigated an error on an i.MX8MM,=20
>> the root
>>  > cause was identified as insufficient alignment on frames sent to=20
>> the RPMB
>>  > device. Fixed in the OP-TEE driver as described below.
>>  > * "rpmb: add Replay Protected Memory Block (RPMB) subsystem"
>>  >   - Adding a missing EXPORT_SYMBOL_GPL()
>>  > * "optee: probe RPMB device using RPMB subsystem"
>>  >   - Replacing the old OPTEE_RPC_CMD_RPMB ABI with=20
>> OPTEE_RPC_CMD_RPMB_FRAMES
>>  >     to get rid of the small header struct rpmb_req (now removed)=20
>> causing
>>  >     the problem.
>>  >   - Matching changes on the secure side + support for=20
>> re-initializing
>>  >     RPMB in case a boot stage has used RPMB, the latter also=20
>> reported by
>>  >     Manuel Traut.
>>  >
>>  > Changes since v4:
>>  > * "rpmb: add Replay Protected Memory Block (RPMB) subsystem"
>>  >   - Describing struct rpmb_descr as RPMB description instead of=20
>> descriptor
>>  > * "mmc: block: register RPMB partition with the RPMB subsystem"
>>  >   - Addressing review comments
>>  >   - Adding more comments for struct rpmb_frame
>>  >   - Fixing assignment of reliable_wr_count and capacity in=20
>> mmc_blk_rpmb_add()
>>  > * "optee: probe RPMB device using RPMB subsystem"
>>  >   - Updating struct rpmb_dev_info to match changes in "rpmb: add=20
>> Replay
>>  >     Protected Memory Block (RPMB) subsystem"
>>  >
>>  > Changes since v3:
>>  > * Move struct rpmb_frame into the MMC driver since the format of=20
>> the RPMB
>>  >   frames depend on the implementation, one format for eMMC,=20
>> another for
>>  >   UFS, and so on
>>  > * "rpmb: add Replay Protected Memory Block (RPMB) subsystem"
>>  >   - Adding Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>>  >   - Adding more description of the API functions
>>  >   - Removing the set_dev_info() op from struct rpmb_ops, the=20
>> needed information
>>  >     is supplied in the arguments to rpmb_dev_register() instead.
>>  >   - Getting rid of struct rpmb_ops since only the route_frames()=20
>> op was
>>  >     remaining, store that op directly in struct rpmb_dev
>>  >   - Changed rpmb_interface_register() and=20
>> rpmb_interface_unregister() to use
>>  >     notifier_block instead of implementing the same thing=20
>> ourselves
>>  > * "mmc: block: register RPMB partition with the RPMB subsystem"
>>  >   - Moving the call to rpmb_dev_register() to be done at the end=20
>> of
>>  >     mmc_blk_probe() when the device is fully available
>>  > * "optee: probe RPMB device using RPMB subsystem"
>>  >   - Use IS_REACHABLE(CONFIG_RPMB) to determine if the RPMB=20
>> subsystem is
>>  >     available
>>  >   - Translate TEE_ERROR_STORAGE_NOT_AVAILABLE if encountered in=20
>> get_devices()
>>  >     to recognize the error in optee_rpmb_scan()
>>  >   - Simplified optee_rpmb_scan() and optee_rpmb_intf_rdev()
>>  >
>>  > Changes since v2:
>>  > * "rpmb: add Replay Protected Memory Block (RPMB) subsystem"
>>  >   - Fixing documentation issues
>>  >   - Adding a "depends on MMC" in the Kconfig
>>  >   - Removed the class-device and the embedded device, struct=20
>> rpmb_dev now
>>  >     relies on the parent device for reference counting as=20
>> requested
>>  >   - Removed the now unneeded rpmb_ops get_resources() and=20
>> put_resources()
>>  >     since references are already taken in=20
>> mmc_blk_alloc_rpmb_part() before
>>  >     rpmb_dev_register() is called
>>  >   - Added rpmb_interface_{,un}register() now that
>>  >     class_interface_{,un}register() can't be used ay longer
>>  > * "mmc: block: register RPMB partition with the RPMB subsystem"
>>  >   - Adding the missing error cleanup in alloc_idata()
>>  >   - Taking the needed reference to md->disk in=20
>> mmc_blk_alloc_rpmb_part()
>>  >     instead of in mmc_rpmb_chrdev_open() and=20
>> rpmb_op_mmc_get_resources()
>>  > * "optee: probe RPMB device using RPMB subsystem"
>>  >   - Registering to get a notification when an RPMB device comes=20
>> online
>>  >   - Probes for RPMB devices each time an RPMB device comes=20
>> online, until
>>  >     a usable device is found
>>  >   - When a usable RPMB device is found, call
>>  >     optee_enumerate_devices(PTA_CMD_GET_DEVICES_RPMB)
>>  >   - Pass type of rpmb in return value from=20
>> OPTEE_RPC_CMD_RPMB_PROBE_NEXT
>>  >
>>  > Changes since Shyam's RFC:
>>  > * Removed the remaining leftover rpmb_cdev_*() function calls
>>  > * Refactored the struct rpmb_ops with all the previous ops=20
>> replaced, in
>>  >   some sense closer to [3] with the route_frames() op
>>  > * Added rpmb_route_frames()
>>  > * Added struct rpmb_frame, enum rpmb_op_result, and enum=20
>> rpmb_type from [3]
>>  > * Removed all functions not needed in the OP-TEE use case
>>  > * Added "mmc: block: register RPMB partition with the RPMB=20
>> subsystem", based
>>  >   on the commit with the same name in [3]
>>  > * Added "optee: probe RPMB device using RPMB subsystem" for=20
>> integration
>>  >   with OP-TEE
>>  > * Moved the RPMB driver into drivers/misc/rpmb-core.c
>>  > * Added my name to MODULE_AUTHOR() in rpmb-core.c
>>  > * Added an rpmb_mutex to serialize access to the IDA
>>  > * Removed the target parameter from all rpmb_*() functions since=20
>> it's
>>  >   currently unused
>>  >
>>  > Jens Wiklander (3):
>>  >   rpmb: add Replay Protected Memory Block (RPMB) subsystem
>>  >   mmc: block: register RPMB partition with the RPMB subsystem
>>  >   optee: probe RPMB device using RPMB subsystem
>>  >
>>  >  MAINTAINERS                       |   7 +
>>  >  drivers/misc/Kconfig              |  10 ++
>>  >  drivers/misc/Makefile             |   1 +
>>  >  drivers/misc/rpmb-core.c          | 233=20
>> +++++++++++++++++++++++++++++
>>  >  drivers/mmc/core/block.c          | 241=20
>> +++++++++++++++++++++++++++++-
>>  >  drivers/tee/optee/core.c          |  30 ++++
>>  >  drivers/tee/optee/device.c        |   7 +
>>  >  drivers/tee/optee/ffa_abi.c       |   8 +
>>  >  drivers/tee/optee/optee_private.h |  21 ++-
>>  >  drivers/tee/optee/optee_rpc_cmd.h |  35 +++++
>>  >  drivers/tee/optee/rpc.c           | 166 ++++++++++++++++++++
>>  >  drivers/tee/optee/smc_abi.c       |   7 +
>>  >  include/linux/rpmb.h              | 136 +++++++++++++++++
>>  >  13 files changed, 899 insertions(+), 3 deletions(-)
>>  >  create mode 100644 drivers/misc/rpmb-core.c
>>  >  create mode 100644 include/linux/rpmb.h
>>  >
>>  > --
>>  > 2.34.1
>>  >
>=20



