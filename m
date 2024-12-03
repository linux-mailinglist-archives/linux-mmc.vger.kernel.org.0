Return-Path: <linux-mmc+bounces-4903-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D08EB9E21A5
	for <lists+linux-mmc@lfdr.de>; Tue,  3 Dec 2024 16:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A90E516A11A
	for <lists+linux-mmc@lfdr.de>; Tue,  3 Dec 2024 15:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020C11F890B;
	Tue,  3 Dec 2024 15:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="LAia4PpJ"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32A01F76CA
	for <linux-mmc@vger.kernel.org>; Tue,  3 Dec 2024 15:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733238568; cv=none; b=g6u13pviBmXeCExo8XpLnq8iG+V4HZCWzkf4ItB1mRHj8CI6qjIsw6lmBR7Wkw/c9tpAjLBK614jYONXU/jsW9KDTNwfv4FpubMRniMB7A8ynueE8Aj4YRpyxm/kKMGv8Y7zfGp2eFietOXTUJ1PmUj0PF/H1BKciraH9b3GikM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733238568; c=relaxed/simple;
	bh=ptJpUzd/BhAIeWpF97J96wy/fzTMEo/QGYZYJybeNNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RDlo3N+2IT5r3Nrgc40tvb5lme+ry6sC1dqTSLGTCkJzmVfEdfWQ/w7GdhMkqC8laIw0mO/7UP3FG0MgNpUYOQObp8qFpaSZATuN8BFiKJ3tcQCVSB3MTfURRUX6mn9MEAs50Wn7cAja/q8NG8OkgIWtUM67yt7A94JrOHl6HKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=LAia4PpJ; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3ea4c550a3fso2748392b6e.2
        for <linux-mmc@vger.kernel.org>; Tue, 03 Dec 2024 07:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733238566; x=1733843366; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ii6/Eam+Rd1w/XN536sPdorZmSq0gN6Qv3+oQutPo10=;
        b=LAia4PpJP2JnNrSS7Ew62eOvhwSKt3vQu9i7e90gsbvhRigAw6QAz0imLnYMfczm5V
         2js3TxBTO6Pkw+ADPGDcANglO35y4ohkV/lYSowWrJbhhY06w9egBCIQ2mW5Y8mBNiVl
         sWEc6tNVjdDmIgkF6NAt/G84skUE0a+prK4zkgW42arkftHiPQzL8DIsqwTu2cdqBBh4
         GN1s4Oi0avDlK0w48OBhoEuxs23XoTT2jI3Ni3Q+du8v72IvrGeCsB/P0Ll68IbcYZiJ
         GrA9xTjD8O1JYuy9hVH5EDj34z0ayO9nH8G+ZQd0ur8xAsWmnTMDdypXvrkAFr7K09ff
         Iiyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733238566; x=1733843366;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ii6/Eam+Rd1w/XN536sPdorZmSq0gN6Qv3+oQutPo10=;
        b=lDqdmWFmPtwsjvg+CFJhT04ytnPousX+nIpsaQ05WziScTjfiwaD87LTZ/UU+M1yfB
         zoKcV6XBP8o/LC1hznptXzJqVtaVbGGNZMKFhNfbzjM3DyYjSasT11uKpcVGeTwGUdKQ
         0UZVJPwutIBIgMTNv49pPwyxnE2dgOqWdxc8pGqTI/naChjqbglSgr0DmgC1Dy6Dg6cC
         f78FtH++wffg7ZqNkCnd8Q22mHCdUXYDfX7O/RLcksZh5EEgToK8YsLAqbMfRMC/wIZz
         urhymmwIZBNDiJswGOpcDJAIpyoIdn7fQDqLz+Ci30Rm7kwuMWLwJ8IUQrtJcvWD5epb
         LabQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKl9AUFVSzHpHxizueCzynmAm1su3aGvGPIbmkztF+sRwX6VRJgF8YYX/kVJtOr7WbEBzK/h3XAj4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9zaoqhnC2Ajq1uGZUels5RidSgfh/C/FMBdR2Sb92L4z4BL76
	Mi2y2CSvdrPl85ySnJMlh2+KC39fbPBJftg4+CVnVMNvqdITH8BSXCMzqGZN02c=
X-Gm-Gg: ASbGnct+aOTRnL/AdsVCX5nQ07OY26xxtKpPfSMukszYHe9RZpT4Nds7kosCVsM88hj
	vBoGM1jhuAUxrJxzvEAW6nlCohqkj/eAfWrjYNEPLJ9C0WX2Z05lRg/MPEWU3BnxUawk6wexWRQ
	XNEYiPHZJcdvzyegUnLEKDai89eooWB3SSB+B/KJqbjSp5TshLMWJST2D6Dv+CL8Cjpcv6i3bN8
	BCizsum/wjOXr09B9R2uPWaaMDux3jx66fcmDT2z0UCbMwh
X-Google-Smtp-Source: AGHT+IHdP/r0VTOfmHgK6zsgpRftwhI0VmkZTrKusX1MqvGl6wn141rPYAXz2iiNvED/ZdfolUyPmA==
X-Received: by 2002:a05:6808:3843:b0:3e8:1f5d:b7f8 with SMTP id 5614622812f47-3eae4edadc4mr3237519b6e.1.1733238565720;
        Tue, 03 Dec 2024 07:09:25 -0800 (PST)
Received: from [172.20.2.46] ([130.250.255.163])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ea8609f140sm2829517b6e.19.2024.12.03.07.09.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 07:09:24 -0800 (PST)
Message-ID: <c3407d1c-6c5c-42ee-b446-ccbab1643a62@kernel.dk>
Date: Tue, 3 Dec 2024 08:09:21 -0700
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v7 00/17] Hardware wrapped key support for QCom ICE
 and UFS core
To: Eric Biggers <ebiggers@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Asutosh Das <quic_asutoshd@quicinc.com>,
 Ritesh Harjani <ritesh.list@gmail.com>, Ulf Hansson
 <ulf.hansson@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Gaurav Kashyap <quic_gaurkash@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Om Prakash Singh <quic_omprsing@quicinc.com>
References: <20241202-wrapped-keys-v7-0-67c3ca3f3282@linaro.org>
 <20241202183643.GB2037@sol.localdomain>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241202183643.GB2037@sol.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/2/24 11:36 AM, Eric Biggers wrote:
> On Mon, Dec 02, 2024 at 01:02:16PM +0100, Bartosz Golaszewski wrote:
>> The previous iteration[1] has been on the list for many weeks without
>> receiving any comments - neither positive nor negative. If there are no
>> objections - could we start discussing how to make these patches go
>> upstream for v6.14?
> 
> The way to do it will be for the block patches to be taken through the block
> tree first.  That will unblock the rest, which can be taken through their
> respective trees in subsequent cycles.

I can queue up patches 1..3 in a separate branch that we can both use,
and that can get pulled into for-6.14/block as well. Didn't want to do
that before the rest of them are ready. IOW, if it's going to be bound
for 6.14, let me know, and I'll setup the branch with the patches.

-- 
Jens Axboe

