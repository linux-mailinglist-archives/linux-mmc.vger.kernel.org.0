Return-Path: <linux-mmc+bounces-635-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9169B82C35A
	for <lists+linux-mmc@lfdr.de>; Fri, 12 Jan 2024 17:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B764D1C224D1
	for <lists+linux-mmc@lfdr.de>; Fri, 12 Jan 2024 16:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BE473169;
	Fri, 12 Jan 2024 16:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="XPZGz+ja"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E2D5731D
	for <linux-mmc@vger.kernel.org>; Fri, 12 Jan 2024 16:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7bb06f56fe9so79873839f.0
        for <linux-mmc@vger.kernel.org>; Fri, 12 Jan 2024 08:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705075845; x=1705680645; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NFWfwHygc2tLtqaZ9kmrB7jXlZ0tclJm6WoKHkdH7fk=;
        b=XPZGz+jaZFS4t2ooJLCdCoQd5eh1V0fJ5CUlVcq1sPAlhk8/gLMs6LY+TmI2a7For2
         bLtDH23MmSRuzgjFKhKOcWo8DG119j3h+iJjS+u3UFF0fEUvr6BINhUs5vRflBcRjTHF
         3xvVm2d+QzMc1hLWkf8dQRG4deMtNWpKFVkaHR6XolUiqxrlZ2jSdCJ/HgnDZ7iw83A/
         MKyXzSX2Ebk5zBXd8ZdO/PhtO1mBbaODd94sSe+ns6zQV3e3cRMZrwes3STg6a/AtkL8
         bd18x6ZAjWaIfzhfRYu9FdRb7lK2BEqI3y4+TruuEmBbNfxGpggvthh+IlE3aRtWvjA4
         b/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705075845; x=1705680645;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NFWfwHygc2tLtqaZ9kmrB7jXlZ0tclJm6WoKHkdH7fk=;
        b=sRD9/xvWjA1ZCC7EfsByoH8VzgZ/iSkQynFoJHQ0tg0vmvEep/lLQCDKURTX0RetVp
         0ra0s6aCJECBDhqMDM11XU6HgLUQYydDZ4XsuRR8KcYzR080N/jNehcj+2L7eli47s02
         RyC1wlRpvGA7FswpCjQMfJl2r2QVHjk2KnY1HRndVpmh6vGF+8QRdyhEvwUZdEV2bXyl
         ICAZxFoX/7XMGNTTDUNVcqnNGbmL3DRjqlO5ROhK69By+gjK4dIWaetUBSdQMTT7gWo1
         jDl/ZL9pz0quM1WlvycxkzMpd2rmOkdn+FjLgAU/E6v5iFmL3aYe9vglKxbU+ErHB1Js
         BRaA==
X-Gm-Message-State: AOJu0Yz7lL0NiT4R4yLkL+vUSadznsKw+ZMNe90pkT9L40t+02tR5eOW
	TxwOxtDGY9V6uBeriulato6i88/dQ86UnQ==
X-Google-Smtp-Source: AGHT+IE5HSi9IwRSj+Eoiwy+OtCZgGENx3FKGiQyFSFBSLtYiehianEJtjDF35mgK6CVa1fFWXukmA==
X-Received: by 2002:a05:6602:2558:b0:7be:f413:e410 with SMTP id cg24-20020a056602255800b007bef413e410mr2103714iob.2.1705075845625;
        Fri, 12 Jan 2024 08:10:45 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id dn15-20020a056638090f00b0046e300e90d5sm937976jab.152.2024.01.12.08.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 08:10:44 -0800 (PST)
Message-ID: <d495b5da-3bdb-4548-9876-78f2080e15e0@kernel.dk>
Date: Fri, 12 Jan 2024 09:10:44 -0700
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] blk-mq: ensure a q_usage_counter reference is held
 when splitting bios
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
References: <20240112054449.GA6829@lst.de>
 <9eb0f18e-f3ce-497c-931d-339efee2190d@kernel.dk>
 <20240112142509.GA6899@lst.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240112142509.GA6899@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/12/24 7:25 AM, Christoph Hellwig wrote:
> On Fri, Jan 12, 2024 at 07:22:18AM -0700, Jens Axboe wrote:
>> Yep it is pretty cheap, but it's not free. Here's a test where we just
>> grab a ref and drop it, which should arguably be cheaper than doing a
>> ref at the top and dropping it at the bottom due to temporal locality:
>>
>>      5.01%     +0.86%  [kernel.vmlinux]  [k] blk_mq_submit_bio
> 
> Ok.  Do you want to send out your version formally?

Sure, can do. I'll pick your first patch here as that one makes
sense separately.

-- 
Jens Axboe



