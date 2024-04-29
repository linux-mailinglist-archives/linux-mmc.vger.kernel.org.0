Return-Path: <linux-mmc+bounces-1990-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E14CE8B4F3D
	for <lists+linux-mmc@lfdr.de>; Mon, 29 Apr 2024 03:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10E421C2106E
	for <lists+linux-mmc@lfdr.de>; Mon, 29 Apr 2024 01:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBD77FD;
	Mon, 29 Apr 2024 01:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="M3ftLRLf"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE405382
	for <linux-mmc@vger.kernel.org>; Mon, 29 Apr 2024 01:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714354814; cv=none; b=dp54hyP2nVb+cowFHEMvz92GBznsA2Q4CGJQlwFArGAJ03Jx40gcsBjEczQkWlH5XSH2HQFVrBIr+kBJF0CH3E/ryrLn93n49Jk2XUGYhfY2ipCCZBeMPFS8MhK5xXSq/uXxMIwrMqqeZ+6ycsH3sffFfPUFFblrjNL72kzW1hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714354814; c=relaxed/simple;
	bh=SlzIObDUj9tcIwgTrHznrmmm98JmaKVXRllhy3BQvCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PyefnjRoLdeUGGGjkeTkvWWrdnBkf1ZvNhVazHNKEzyccZmkmbigztzVlwLe2zJY+LzzQanMkDh4SEToCqFQU3HXaYvRiASyYr1xr7IxvZSCcFfEJsiqCNEVilV42sfm1kDK1pPFz+clhkKiFgZnNhwBDJFoi676zh0LaKyBZRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=M3ftLRLf; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6eff2be3b33so3684366b3a.2
        for <linux-mmc@vger.kernel.org>; Sun, 28 Apr 2024 18:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1714354812; x=1714959612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KM3bRl7wstvhhcRxTT2u4kalxasADFMxdUz/Zr7T9hU=;
        b=M3ftLRLf7QJJ3R2n7yOKMQI/sk2p2+WcUw0BCHZjm5MUKZj2JIxu7sbW46BqNrG0cA
         hx8/lLqTBkq0Q2SKRBF5antm4ja5Zc3WOnucc/sD3AUTjb1KFkI94+kYbbZhhJrCQs/S
         q467L99LlCZx01nEU3KV60THytsRMMEm0ZS5mU5v1RT4xKthpvMFQEG9ZxnlwDDtLdUZ
         QtSjXCkn+ojjma1bemi1rTofQGrk/28zWBgLf5vsRY+qO5QllwU0BYpHGsvqz4qH4RDJ
         TlOjaxc1NM3OaV7+sofMxsoNi7LcDvHCHTqM6svxUJ9XHB8z9USbQ0gSRg4knfTj/dfQ
         shNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714354812; x=1714959612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KM3bRl7wstvhhcRxTT2u4kalxasADFMxdUz/Zr7T9hU=;
        b=A9+kYaOWVCC0DaK/qhYVGQArXVIhqVoUjFMJ5cZxn092iR4hkWdY1L5k6H4emn6U2W
         iJ95rKYKkXhLXVuILGVyPuuCkrLe3Vt1/vbXWwx6N/hPbdGto1tq1knWBCMyajvX9HCG
         DavqJYBilSdhb0He0WRehEeAnNlvP0q3QTXHGXwjsXxPP7Q4m4bGHfh1Z9qmwvFnWSyL
         d0GgheRp7idpcIixXm/Astk5EP2MpYh+1KkbKIJYBHPE5uEpGpn9COIX/yFBMuLOPkTl
         Td63FckO+7xdr60zmzzgcvkI3pTSM1rDk3OhIFroKc/u1U6QI4wsJLimCLiNa45juMMU
         hvmA==
X-Forwarded-Encrypted: i=1; AJvYcCURtc0TcHzknTQoJfH0RKzbfiCQu5nH87zjZG375iqtRbxMAmSvvybw57Igt82/s+qfZFaGIOLe9wZm+yQabReSywxm9vyy7esn
X-Gm-Message-State: AOJu0YyayVM6Fp9SV/icWQIYdabucAsnd9XWgYwdDrQLgNfJ3dnIYJJH
	NZWzeLctUr7qQsnG49BqcnIwCKE3CLAABGQmjcTAycZFVURFJIOaaFWNrS3+0sw=
X-Google-Smtp-Source: AGHT+IHQWceseBfutCgTsVmWE3K2qO9B8qQxnkTs4ilJTS9ihwvNqLl4CyZoGlmFScXKnhdB9FyS6g==
X-Received: by 2002:a05:6a20:551d:b0:1aa:5ca9:c565 with SMTP id ko29-20020a056a20551d00b001aa5ca9c565mr9211300pzb.8.1714354811627;
        Sun, 28 Apr 2024 18:40:11 -0700 (PDT)
Received: from x1 ([2601:1c2:1802:170:2954:ea28:74e3:df7e])
        by smtp.gmail.com with ESMTPSA id l14-20020a170903120e00b001e555697361sm19005421plh.220.2024.04.28.18.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 18:40:11 -0700 (PDT)
Date: Sun, 28 Apr 2024 18:40:09 -0700
From: Drew Fustini <dfustini@tenstorrent.com>
To: Chen Wang <unicornxw@gmail.com>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	jszhang@kernel.org, dfustini@baylibre.com,
	yifeng.zhao@rock-chips.com, shawn.lin@rock-chips.com,
	chao.wei@sophgo.com, haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com, tingzhu.wang@sophgo.com,
	guoren@kernel.org, inochiama@outlook.com, unicorn_wang@outlook.com
Subject: Re: [PATCH v2 1/1] mmc: sdhci-of-dwcmshc: add callback functions for
 dwcmshc_priv
Message-ID: <Zi76efedrI6Uv3f3@x1>
References: <cover.1714270290.git.unicorn_wang@outlook.com>
 <5bb708cc830684676dede5f44ee22c7fd03300b7.1714270290.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bb708cc830684676dede5f44ee22c7fd03300b7.1714270290.git.unicorn_wang@outlook.com>

On Sun, Apr 28, 2024 at 10:32:41AM +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> The current framework is not easily extended to support new SOCs.
> For example, in the current code we see that the SOC-level
> structure `rk35xx_priv` and related logic are distributed in
> functions such as dwcmshc_probe/dwcmshc_remove/dwcmshc_suspend/......,
> which is inappropriate.
> 
> The solution is to abstract some possible common operations of soc
> into virtual members of `dwcmshc_priv`. Each soc implements its own
> corresponding callback function and registers it in init function.
> dwcmshc framework is responsible for calling these callback functions
> in those dwcmshc_xxx functions.
> 
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>

I have tested this with the eMMC and microSD on the Lichee Pi 4a which
has the T-Head TH1520 SoC.

Tested-by: Drew Fustini <dfustini@tenstorrent.com> # TH1520

Thanks,
Drew

