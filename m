Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C608F2FFD81
	for <lists+linux-mmc@lfdr.de>; Fri, 22 Jan 2021 08:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbhAVHh4 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 22 Jan 2021 02:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbhAVHhx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Jan 2021 02:37:53 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DFCC061788
        for <linux-mmc@vger.kernel.org>; Thu, 21 Jan 2021 23:37:12 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id w18so3164622pfu.9
        for <linux-mmc@vger.kernel.org>; Thu, 21 Jan 2021 23:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xnObBx7qCVcq4Xmng0HzOiOYW//hrsobDgYRbXW2qoA=;
        b=dfhsrZgi1qJDI2m/ilO0UZ7ihv26w0btzlf1zmTicpi6ZJPqGMSAzlb7G4wGiF0FW3
         Gijmj6YCtu3PwTEsxPDNKVLwzNJfoZ+kzsARJbaXfKhjIPk0hIdEI6k7+iABd3J0Ge6o
         E21BaI1DVfxYzhQmtffSyiTWTX0ggTKcY1OLoksddvORRrvfQMQGbsphmp1xU/IKzC+G
         sD/zie7QvCQK1vih68EwWOxT3P4AOnndd/VBNtbw7iZsbzo+OPZQFBdc76x6uF8HLA4t
         egiWvXKCvt0EJ4zf4Nru3997s4IFCMrrcBcXNTQ8OpxxqBRXA3kIBOHmAEsIKhM9WxEA
         fFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xnObBx7qCVcq4Xmng0HzOiOYW//hrsobDgYRbXW2qoA=;
        b=dnvr99arQc/doouPXnzE6ALtQaA71hhKrdP2DEZDb9LQDtUPi4833Fw6D5IT/y8qK/
         GwPstNw26XkjWRSgKxtZCrgXe7aUhuHoxOFOKa/HrBxjChkB9L2H06UCG+ZGJhLJsLwc
         AK532rr1xaf4uZpTRsEiApwp2JeusPxZtX2jsXESMIF60+tu/sIahe4ZbWO0hTT9ImMU
         9JpjIaZeIWKWjhr0zzYMzipwv7DMGV19BQ3/RVIBR6Yp3X0SNC2N80+Qblx4SF07ytuh
         QDvVjMW6mjUZEC6MjzVD53N35mu2XLHBQAFw0zKX5k5qjVNrmnfUT4z2kZj5SR/1LAlE
         sqNA==
X-Gm-Message-State: AOAM530rqqtT/BclRcG8/l32zXMx/E5I5El/HEg/UQPnFk3rnBIVYlx6
        NQfxKqb7+Qf/yTkRuR3eucf5DhiZXDWF3fRt
X-Google-Smtp-Source: ABdhPJwPLaEjEPKwC34UrAC2gsulKg3s4j7+J97bZTNNIKaoZ/lJu48wNw2Iwm4BkDrJnbbca6y71A==
X-Received: by 2002:a63:1f18:: with SMTP id f24mr3506723pgf.133.1611301030526;
        Thu, 21 Jan 2021 23:37:10 -0800 (PST)
Received: from [10.8.0.116] ([196.245.9.36])
        by smtp.gmail.com with ESMTPSA id fh7sm7835085pjb.43.2021.01.21.23.37.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 23:37:09 -0800 (PST)
Subject: Re: [PATCH 1/2] block: remove unnecessary argument from
 blk_execute_rq_nowait
To:     Christoph Hellwig <hch@infradead.org>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        target-devel@vger.kernel.org, linux-scsi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-ide@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
References: <20210121142905.13089-1-guoqing.jiang@cloud.ionos.com>
 <20210121142905.13089-2-guoqing.jiang@cloud.ionos.com>
 <20210121170257.GA4120717@infradead.org>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <b87591b9-e598-6436-d41f-80cc56640549@cloud.ionos.com>
Date:   Fri, 22 Jan 2021 08:36:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210121170257.GA4120717@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 1/21/21 18:02, Christoph Hellwig wrote:
> On Thu, Jan 21, 2021 at 03:29:04PM +0100, Guoqing Jiang wrote:
>> The 'q' is not used since commit a1ce35fa4985 ("block: remove dead
>> elevator code"), also update the comment of the function.
> 
> And more importantly it never really was needed to start with given
> that we can triviall derive it from struct request.

Thanks Christoph, will add the above to header and send new version.

Guoqing
