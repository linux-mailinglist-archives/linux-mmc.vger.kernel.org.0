Return-Path: <linux-mmc+bounces-2610-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6715290A7DA
	for <lists+linux-mmc@lfdr.de>; Mon, 17 Jun 2024 09:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 152EA2810A7
	for <lists+linux-mmc@lfdr.de>; Mon, 17 Jun 2024 07:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A3519049C;
	Mon, 17 Jun 2024 07:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="PRV+DM6j"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7185F19004D
	for <linux-mmc@vger.kernel.org>; Mon, 17 Jun 2024 07:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718610956; cv=none; b=ov9X/2aMGbS/8aXG5Ygh/cVO4+DwCSQkb3gS8lQPpQVShs7eVAjNcNyPG6JGyuuC3RmFawkrX2KTV2ROiNtFO+qYWrQgtjocAGAdJskFUXKIBXkzpzIla/nLVF2WuEwxzzHDWnB1zD0Eq1eCpbs49tlCnm6gmQFshAmb6D5Q2A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718610956; c=relaxed/simple;
	bh=JhFXSTpTbZnynjs4GWaWiZ25aqQJvGOYbY3MGHI2j0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cX+SVXK5TR3Ik1/FRGLJCyUvQCbjjku8voir+wAzO77QNarfPkGFFpjZdziL+1Cla4vMLeXtv0UsscdzuSDrAQEhppks/cAH7E/dBW8DoSzs+7HXRPxC+lpCI6oI6A4GjdnaFZ3BnXcu7+zhYCL6w4zEuHQ1wlBGnPtI9S5Dmdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=PRV+DM6j; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4421c014b95so20836171cf.0
        for <linux-mmc@vger.kernel.org>; Mon, 17 Jun 2024 00:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1718610952; x=1719215752; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6I7HjTVD0FYGpGJyzdWr9lYyHGbtAeqv6wNa85E5Tlk=;
        b=PRV+DM6jEikbSJU+DC5oCjO9958pbLBhKoPEJFulkR6ypvkc5V6majzBGPX6ggfkHc
         JiqGZGqqKzIJrQBdH4mNGx2m9AOdeXg5HpVebQwqGi7bQt2+J4qCU0N99ekRoZdJzQu+
         7nJ/4+iQ7Gvdt/6F6LxjcFTJZ65VNeGv/HMbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718610952; x=1719215752;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6I7HjTVD0FYGpGJyzdWr9lYyHGbtAeqv6wNa85E5Tlk=;
        b=CcQ+ZD1rry+wGeS4xxI8g0Dhb2331rf0Ak3gTCA9vVC/wTqDp4NoIwVRtIqlEiLY0F
         EK8T9C0MjUMDwpz8GJ2Gtz5+l+H7MYX1ebAB7fLpPlr7zS2RrEwzXx9fq9k4pHWnKTYU
         wmUEhHQWkJZoOtJw8cNUOsOau+4cdJ1J1GR0e5HZJuCXtJUNv5fS9NXbcwHayuQmkKKg
         iEqR3ap171r/G8X9/CVsEWApMa+/afL5ObWPkOMxwyX/iUpt5bUQZicoATU8Yvqn+bXG
         NIOYixzVe+4ltnsEsEpT2NDcUAExqWA1poYFkAstfAcBHZpkAHKPm/e6ji73HbQd1jjz
         8zfA==
X-Forwarded-Encrypted: i=1; AJvYcCUsOup2/0AQ9sDRPD38toBK3iZG+QLW8u6SUTnGOeiHOEcqGrC/fvClWEPTRnOWIgtD3ugXZTHhUNpFr7960jspiqxWqOYWSrTq
X-Gm-Message-State: AOJu0YxWnbRCy+jJp1m9OPDoYOHVAdxawat1hx5ajpOp5a43f8sBS43W
	apMqQhV8i/TDhf/bFXiFPxEPSQ0MU0CjnAeIs1/J3Pd9DMO5l7RJ9WYckXjd98w=
X-Google-Smtp-Source: AGHT+IFxBb+fxu+zFP9/mPYH5nZSCdE6S/NGqQ55TdkfvSsNQ6okiuS1Itv2iysUUW0wZGmJIGDYbg==
X-Received: by 2002:ac8:5e11:0:b0:440:10be:3ecf with SMTP id d75a77b69052e-4417ac402c0mr199666251cf.22.1718610952095;
        Mon, 17 Jun 2024 00:55:52 -0700 (PDT)
Received: from localhost ([213.195.124.163])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441ef4eefaesm44094171cf.21.2024.06.17.00.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 00:55:51 -0700 (PDT)
Date: Mon, 17 Jun 2024 09:55:48 +0200
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Geert Uytterhoeven <geert@linux-m68k.org>,
	Richard Weinberger <richard@nod.at>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Josef Bacik <josef@toxicpanda.com>, Ming Lei <ming.lei@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-m68k@lists.linux-m68k.org, linux-um@lists.infradead.org,
	drbd-dev@lists.linbit.com, nbd@other.debian.org,
	linuxppc-dev@lists.ozlabs.org, ceph-devel@vger.kernel.org,
	virtualization@lists.linux.dev, xen-devel@lists.xenproject.org,
	linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-mtd@lists.infradead.org, nvdimm@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 01/26] xen-blkfront: don't disable cache flushes when
 they fail
Message-ID: <Zm_sBInagtSkOZtg@macbook>
References: <20240617060532.127975-1-hch@lst.de>
 <20240617060532.127975-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240617060532.127975-2-hch@lst.de>

On Mon, Jun 17, 2024 at 08:04:28AM +0200, Christoph Hellwig wrote:
> blkfront always had a robust negotiation protocol for detecting a write
> cache.  Stop simply disabling cache flushes in the block layer as the
> flags handling is moving to the atomic queue limits API that needs
> user context to freeze the queue for that.  Instead handle the case
> of the feature flags cleared inside of blkfront.  This removes old
> debug code to check for such a mismatch which was previously impossible
> to hit, including the check for passthrough requests that blkfront
> never used to start with.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Roger Pau Monné <roger.pau@citrix.com>

Thanks, Roger.

