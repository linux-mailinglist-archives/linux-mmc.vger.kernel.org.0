Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA64397490
	for <lists+linux-mmc@lfdr.de>; Tue,  1 Jun 2021 15:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbhFANtx (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 1 Jun 2021 09:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234074AbhFANtw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Jun 2021 09:49:52 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B443BC061574
        for <linux-mmc@vger.kernel.org>; Tue,  1 Jun 2021 06:48:10 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id h9so15555952oih.4
        for <linux-mmc@vger.kernel.org>; Tue, 01 Jun 2021 06:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QlGkt7fWsHM9mcKdq1bDx/YwBl/iUUk0WEjc5rg04fY=;
        b=SJMAgBW5mswAe1ZmlZlRdAFuvYPDEVLqi723Nnx1S4FLz3Yy3Tj3lQWVdZ0F6Qr4eS
         SMIy05Vpx5EU+XswU9cem+w+MzG0a62ahvk23Tf2SUyNvaWPkh1rlmu3OkVCdEssPf8k
         xwwmCV/LazyU6UjgCMJxdw//dP9UOpzUM54yyNCR3QG30hScN/IqdhxGg71hNvOalyX+
         pO6I2f3s4rBYqGHOnzUAspl9mEOwDLA0qywJ9pSLvD5fVKPzw+UNtHhfYY4OA0aw1ASO
         zcdxwDDiGjJD5VEZLuOr0Rlq6ubnYTbGW3SYaGllJ+Xvfy3vmm5YD3DkNvXi1rVEGPqw
         8g9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QlGkt7fWsHM9mcKdq1bDx/YwBl/iUUk0WEjc5rg04fY=;
        b=UBE4Kqh2KsRcBibwhfAEDCFX/ZHVsxJ+q3qYjCQiknDyHbrzdPWdEh7l97PNlj+ETK
         LLXa6aVYtTczj/dQHBVTMC5uNVl0+r3FOVBw8Uh8Zxo5GSBiyRGJvwkmB3PsbRG6u2G7
         Hw67rQAjvb6gflXTpMlrvNyHki4GT4ae7D46EKcf/AbMUwmgyKrXSM90EBGN3DqIFaSM
         axajurpWmFkvz+NuInUdnVutVkBTlR9w5I3libAMpfe8BV4l+qRZzShGPvJO3S24bBEt
         X+NLJqX8ESbok9iQy7z+GyW7pS2X+7/sLR+4HuJB93A0bwk5waCXXvuUavUV+UnD4TO/
         kpUA==
X-Gm-Message-State: AOAM530/nO3CQdamfEQTRzb6kUgaxtDuuPL571WgM8SxamXuLo4yPATk
        DjbItCNy9PtzG3LQehCzaPCnJg==
X-Google-Smtp-Source: ABdhPJyRtEOQYxSXItYfv2Xv0el0nwhIYWVK6zfd5YIEz7fo5+/L3t2bxzT7qaz6PyG5RR7CPJmZJA==
X-Received: by 2002:a05:6808:245:: with SMTP id m5mr18302900oie.6.1622555290008;
        Tue, 01 Jun 2021 06:48:10 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id i4sm3456045oih.13.2021.06.01.06.48.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 06:48:09 -0700 (PDT)
Subject: Re: simplify gendisk and request_queue allocation for bio based
 drivers
To:     Christoph Hellwig <hch@lst.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jim Paris <jim@jtan.com>,
        Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Matias Bjorling <mb@lightnvm.io>, Coly Li <colyli@suse.de>,
        Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-m68k@lists.linux-m68k.org, linux-xtensa@linux-xtensa.org,
        drbd-dev@lists.linbit.com, linuxppc-dev@lists.ozlabs.org,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-mmc@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org
References: <20210521055116.1053587-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a5d7127f-b422-5556-6810-cf4c98c038ac@kernel.dk>
Date:   Tue, 1 Jun 2021 07:48:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210521055116.1053587-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 5/20/21 11:50 PM, Christoph Hellwig wrote:
> Hi all,
> 
> this series is the first part of cleaning up lifetimes and allocation of
> the gendisk and request_queue structure.  It adds a new interface to
> allocate the disk and queue together for bio based drivers, and a helper
> for cleanup/free them when a driver is unloaded or a device is removed.
> 
> Together this removes the need to treat the gendisk and request_queue
> as separate entities for bio based drivers.

Applied, thanks.

-- 
Jens Axboe

