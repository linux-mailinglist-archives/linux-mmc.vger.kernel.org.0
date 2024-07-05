Return-Path: <linux-mmc+bounces-2977-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9CC928257
	for <lists+linux-mmc@lfdr.de>; Fri,  5 Jul 2024 08:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DED981F234FF
	for <lists+linux-mmc@lfdr.de>; Fri,  5 Jul 2024 06:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E0A1311A3;
	Fri,  5 Jul 2024 06:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="eW8rNNJd"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0892175BE
	for <linux-mmc@vger.kernel.org>; Fri,  5 Jul 2024 06:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720162428; cv=none; b=drDjXlejIxvf3mW/FVo+TiDprM/UKE+UpEBs1rOdPzt7pGjML9Sez/goWkuNR6wh58tN6HnXg1OVJEh1lu4NhtLq1jQ5QVGSxtl54v5MSkv+riz/nliQEhOjfRrB/1gPqlOhcqQST2xV88vVBaggkLmYeNrMxt7Q1nIYkEryhZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720162428; c=relaxed/simple;
	bh=4jf1tFaStZgMkcMzqTL6XYQMKykcRb2/mzg7mktiEmw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iYJOsI0JanANRBdQX/07gk/Z+SwTaF5e2S4rspTfvvDeZBAMvSNCMZ4AhtPkDn3TkpqVYxsJhN0/i6ViNJz5m7Xws0d6y9MZDP7ZuWM5/drpA1mMNcA4Ed1JP1Zcdp7RvHEUZyoJEKRUxtSp9fRjFJTegFYWLIFlURGAdMSp4XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=eW8rNNJd; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52ea333534cso82830e87.3
        for <linux-mmc@vger.kernel.org>; Thu, 04 Jul 2024 23:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1720162425; x=1720767225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7Z4x0yivXPXPEQUo6hw4ab/l5O+fZbFelcOZbk2dRc=;
        b=eW8rNNJdvk4XVMO1LJeq3E3LcRRqRX/6yaH1cu75d/RwgCkorM51wcy4yKWwtyJr+J
         keKUyMKARcIQLAiBRLkkJihOKOV89m5H/Rxv3wXGiIO+h2UOtdy62fqfeE9SAYfUNSqn
         4REhhFQayxd4kBl78bTWIuwRAGcDbGfBzLr5o4caSwqLerQEcQD+b0NEwXOGiYT0MtIN
         c+7uups375o0Q17rXc3OCG2JViB8TMgUd2ATrbmf9/CvDm3PlqcCSEAHH+SOA8nEQiQF
         N9WSqMnWpVhNH40ePmY0aY0txdPwUYXHwbkeEBhxju8jV2THP19Ta8seJa+X/EBG4VLI
         SZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720162425; x=1720767225;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M7Z4x0yivXPXPEQUo6hw4ab/l5O+fZbFelcOZbk2dRc=;
        b=Rv7zZi1WvEiRLtQze1L+RaBNPsDJSTflXtYOtxvDW1GXZi+cwWS+I1ALl0o357r1KJ
         9rZdCq+EPMGGlRsUjzvbCWX55R8iBpzTEjTUF7ylRF0U6ibcDvbqYRZvrG9sFhMA9NmH
         WPsVYX2KqTNtfFuaJimDBvZUQOeyunfgw5/+dJuOyOFciBDRcBxhsyAijMv+UGmkMH8w
         +i0q4q3EDXRw5tJFCHdfHSyBBVfHAVxNAqhBK/lkQRVgdU0xNO3wV6VhJBggqdmymR09
         Zvsa91gj34bgvgnXR14WRKITRrnAfnwd8F7ZlgSOpU+V5VIGOa/W0iADDqJ3V9Kp2nxm
         SqTg==
X-Forwarded-Encrypted: i=1; AJvYcCW1yq0Pcth7av4VQ43RMwkOAGiX2HVIblup0s4GbfSghVSiPIeI8IJxWOg3w1hcxjvK2Kkc06SPPqxf6Np0KTeVPteR4rlp/1Do
X-Gm-Message-State: AOJu0YzYeBFWyI+/x/A+nOfVuTP9spSbah9HuDvHEf/PoXN1WPJw5yhr
	xPBBZuZ+wePFIZSGtLaK6ejiPJ7W06keLYJF39NpBBGbTL1Mnk1uH+I+hbZPz0w=
X-Google-Smtp-Source: AGHT+IFNfczTdv82eTZ+LXF4VCvbd5GD/iOKJOT+F5id4a0Gm8xm5UmFmV8h6VwvKjkr+VMnWcCeLQ==
X-Received: by 2002:a19:4308:0:b0:52c:ce28:82bf with SMTP id 2adb3069b0e04-52ea075dd8bmr2005667e87.5.1720162425042;
        Thu, 04 Jul 2024 23:53:45 -0700 (PDT)
Received: from [127.0.0.1] (87-52-80-167-dynamic.dk.customer.tdc.net. [87.52.80.167])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e930e0696sm1013105e87.94.2024.07.04.23.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 23:53:44 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Conrad Meyer <conradmeyer@meta.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, 
 linux-block@vger.kernel.org
In-Reply-To: <20240701165219.1571322-1-hch@lst.de>
References: <20240701165219.1571322-1-hch@lst.de>
Subject: Re: (subset) make secure erase and write zeroes ioctls
 interruptible as well
Message-Id: <172016242389.244840.16151813125838031053.b4-ty@kernel.dk>
Date: Fri, 05 Jul 2024 00:53:43 -0600
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Mon, 01 Jul 2024 18:51:10 +0200, Christoph Hellwig wrote:
> Following discard in the last merge window, this series also makes secure
> erase and discard interruptible by fatal signals.
> 
> The secure erase side is a straight port of the discard support.
> Unfortunately I don't have a way to test it, so I'm adding the eMMC
> maintainer as that is where the support originated so maybe they can
> give it a spin?  (just do a blkdiscard -f -s /dev/<dev> and then Ctrl+C)
> 
> [...]

Applied, thanks!

[05/10] block: factor out a blk_write_zeroes_limit helper
        commit: 73a768d5f95533574bb8ace34eb683a88c40509e
[06/10] block: remove the LBA alignment check in __blkdev_issue_zeroout
        commit: ff760a8f0d09f4ba7574ae2ca8be987854f5246d
[07/10] block: move read-only and supported checks into (__)blkdev_issue_zeroout
        commit: f6eacb26541ad1eabc40d7e9f5cd86bae7dc0b46
[08/10] block: refacto blkdev_issue_zeroout
        commit: 99800ced26b9d87a918aa9824881bdb90a3c1b03
[09/10] block: limit the Write Zeroes to manually writing zeroes fallback
        commit: 39722a2f2bcd82bdecc226711412d88b54fcb05b
[10/10] blk-lib: check for kill signal in ioctl BLKZEROOUT
        commit: bf86bcdb40123ee99669ee91b67e023669433a1a

Best regards,
-- 
Jens Axboe




