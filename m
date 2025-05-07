Return-Path: <linux-mmc+bounces-6460-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8307AAE692
	for <lists+linux-mmc@lfdr.de>; Wed,  7 May 2025 18:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A4CC17898D
	for <lists+linux-mmc@lfdr.de>; Wed,  7 May 2025 16:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0654028BA9F;
	Wed,  7 May 2025 16:24:47 +0000 (UTC)
X-Original-To: linux-mmc@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CAD28A721
	for <linux-mmc@vger.kernel.org>; Wed,  7 May 2025 16:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746635086; cv=none; b=JhepnyY+76dx/3Hq47gApaNcclcfz61AwQvOXvtY92QRexAKY9zB8/ejl8a8vmqlvJOGz5E0AVX/e1Wnt7O/QajCI9ArXeaZDNraA68Ive/2LMKMMSVhMCHuJ1c3L/CAKi5NXgW+pYM3+RFpzTkUjOw5YCo7qwREHjkYoSCviH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746635086; c=relaxed/simple;
	bh=nqpCCru5vpj7hrOWoi3hKzRDHzM59HnACs2LIao0n5o=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=FdGC8EYk0XCnFPqybN9EFj707BUeg1FC/R65WDLHl59tpWq9Kp2P27hF5GfhOe2X54ZUdZaA9A4iT1t+jso4PwmdUEm54EWlVPV0/YvjkR+vdMLYH4sT+l1b/YMPTNmJO0ogpYxFh6rLH4unHp56SSQ35lFzgV/y4k/h7W/IPbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1uChZU-0001RP-2W; Wed, 07 May 2025 18:24:36 +0200
Message-ID: <4e1600a7-24d4-454a-87d6-6528b1c4c88d@pengutronix.de>
Date: Wed, 7 May 2025 18:24:34 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE, de-BE
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: [RFC] block: Make MMC respect REQ_NOUNMAP?
To: "Darrick J. Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 linux-block@vger.kernel.org, linux-mmc@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org

Hi,

We would like to tell storage (mostly eMMC, but not exclusively though) to
discard a block range, so it reads back zeroes and is preferably unmapped
to give the storage device the most flexibility. For eMMCs, this is possible
right now with blkdiscard -z (BLKZEROOUT), but digging through the code with Jan,
I am starting to question whether eMMC is correctly implementing REQ_OP_WRITE_ZEROES
(granted, the expected semantics seem to be spelt out nowhere).

Read along for what MMC does, what semantics BLKZEROOUT seems to should have,
and what I think might need to be done to address this.


eMMC supports a number of different commands for erasing/discarding data[1].
Relevant to my question are two commands:

  DISCARD: Host no longer needs the data and doesn't care about value
           read from it. Card may remove or unmap portions or all of it.

  TRIM:    implies DISCARD and additionally guarantees to
           return all-zero or all-ones on read.

These are made available to the block layer as follows:

  REQ_OP_DISCARD      -> DISCARD
  REQ_OP_WRITE_ZEROES -> TRIM (if erased_byte == 0, otherwise
  if all-ones, blk_queue_max_write_zeroes_sectors() is not called)

Looking at it from the ioctl side:

blkdev_common_ioctl(..., BLKZEROOUT, ...)
    blk_ioctl_zeroout
        blkdev_issue_zeroout(..., BLKDEV_ZERO_NOUNMAP)
            __blkdev_issue_write_zeroes(..., BLKDEV_ZERO_NOUNMAP)
	    submit_bio_wait(bio->bi_opf = REQ_NOUNMAP)

__REQ_NOUNMAP has comment saying 'do not free blocks when zeroing',
but as shown above, TRIM allows the card to unmap the indicated region.

REQ_NOUNMAP has no other documentation, but virtio inverts it and translates
it to VIRTIO_BLK_WRITE_ZEROES_FLAG_UNMAP, which is documented as follows[2]:

"For write zeroes commands, if the unmap is set, the device MAY deallocate
the specified range of sectors in the device backend storage, as if the
discard command had been sent.".

I.e. REQ_NOUNMAP -> device MAY NOT deallocate

This is at odds with the MMC implementation, which ignores REQ_NOUNMAP
completely it seems. I don't believe there is a MMC command for write zeroes
without discard short of actually writing zeroes, so it sounds like the
correct implementation for MMC would be:

	if (req->cmd_flags & REQ_NOUNMAP)
		// or w/e causes fallback to __blkdev_issue_zero_pages
		return -EOPNOTSUPP;
	// do TRIM as before

Of course, this will change user visible behavior: blkdiscard -z will start
taking much longer for most users. These users will have to migrate to
using fallocate instead:

blkdev_fallocate(mode = FALLOC_FL_ZERO_RANGE):
	blkdev_issue_zeroout(..., BLKDEV_ZERO_NOUNMAP)

blkdev_fallocate(mode = FALLOC_FL_PUNCH_HOLE)
	blkdev_issue_zeroout(..., BLKDEV_ZERO_NOFALLBACK)

So, it's not a drop-in replacement. I guess user code can punch hole
with fallback to BLKZEROOUT if it fails in order to get back the old
behavior.

I must admit I don't even know why one would write zeroes and care about
them remaining mapped on the storage device, but that seems to be
what's expected with BLKZEROOUT.


Thoughts? What did I miss?

Thanks,
Ahmad

[1]: For a short and incomplete summary, see:
     https://github.com/barebox/barebox/commit/91a11c7d50df91
[1]: https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01.html
     5.2.6.2 Device Requirements: Device Operation


-- 
Pengutronix e.K.                  |                             |
Steuerwalder Str. 21              | http://www.pengutronix.de/  |
31137 Hildesheim, Germany         | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686  | Fax:   +49-5121-206917-5555 |


