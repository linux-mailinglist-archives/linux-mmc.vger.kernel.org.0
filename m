Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 125A6B8A9E
	for <lists+linux-mmc@lfdr.de>; Fri, 20 Sep 2019 07:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392345AbfITFt7 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 20 Sep 2019 01:49:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33048 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389862AbfITFt6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Sep 2019 01:49:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id b9so5448985wrs.0
        for <linux-mmc@vger.kernel.org>; Thu, 19 Sep 2019 22:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uRLxhAVojptV7hgufrR07c/bFSb5W8HdGjW/XXrGNmU=;
        b=PJwrRasi1kvi4TmmQYpADULUr/CFngg3AmxStXvpOMMd9XLvfW6gLqmv9AnclVnZdR
         SuQ1zMH/YhetXtvCG729brMaADmj4KIkDQV9Ni60QWyN6rZLQ4t9xKUIJBF6FmmB3drE
         GpLZifw7YgMCRV0FXOBLZJdclkPTEfbN3vYABril5hbKhU1eT8u0Pr95hcxkjxFFN2OF
         qJUb6E7w4OdWUifrRkp3CUX0mHTukoji4GQDtnghQsabqlL2KFy6v+gNSJ1CfGG6afOE
         woxcInQwT3lg7vY7kYqHMRtm5EO2osE7C0HtTuLX+yoz33vClM6KLedQqiG0iEbqKMfM
         IPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uRLxhAVojptV7hgufrR07c/bFSb5W8HdGjW/XXrGNmU=;
        b=h3LUjyruq5dC/SZrRihhlr8UOBgULZ2cldcZJAjWea7V02imhIhcCT1tU4bO74M3k0
         i2JTPNc8ERNoefqHNQpPtCpjixBelUTAYfQB1aIBpm8fXLmah5SCYk+6RRVsaJstgk60
         6uhqeGkkJrrffYgyLb8b0Y6hRDZi5hSRHmVmDfl1SA9MeKuIl+Qsh7WZF1TL8Rk63g+v
         5N/EUrfVZG8ejoCLzB1484DiacrDjprtosGM3T96VqcJnjNvXPVIfa8yQ2JZb2Q7cqER
         a+cTFTQnNA1+MLs00a1DGZBgSOpJzCqShuL+DGrBpgq0CkplqNll7Hj/85mT+NjSJVNe
         aQ/g==
X-Gm-Message-State: APjAAAVZOsuAl6uhvnGOyfkDfp+US3R3FNp/RbiHfnOS6SZ/VyQpsElg
        eX9eMd4AnUFHb929/7fS+cQjfsOSGoraJQ==
X-Google-Smtp-Source: APXvYqw84BAy83Ziqr1cUVL1uIreNc5GnWBmxBOqLpZzveJLBRsyNiy8z1SV97YD/7CEFzhiHlV8PA==
X-Received: by 2002:a5d:49cb:: with SMTP id t11mr2692912wrs.158.1568958596630;
        Thu, 19 Sep 2019 22:49:56 -0700 (PDT)
Received: from [74.125.133.108] ([149.199.62.129])
        by smtp.gmail.com with ESMTPSA id i14sm903253wra.78.2019.09.19.22.49.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2019 22:49:55 -0700 (PDT)
Subject: Re: [GIT PULL] dma-mapping updates for 5.4
To:     Michael Ellerman <michael@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-mmc@vger.kernel.org,
        iommu <iommu@lists.linux-foundation.org>,
        xen-devel@lists.xenproject.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190918152748.GA21241@infradead.org>
 <CAHk-=wjXF63BKNJH=GtnnoJmXZHEnRwjgeu4foJQvFYYBm9HHA@mail.gmail.com>
 <D422FEED-06F6-44BE-955F-90318693FD96@ellerman.id.au>
From:   Michal Simek <monstr@monstr.eu>
Message-ID: <5cc09e92-96ce-dc40-4bc1-f10a4cad6f7d@monstr.eu>
Date:   Fri, 20 Sep 2019 07:49:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <D422FEED-06F6-44BE-955F-90318693FD96@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 20. 09. 19 1:17, Michael Ellerman wrote:
> 
> 
> On 20 September 2019 6:33:50 am AEST, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>> On Wed, Sep 18, 2019 at 8:27 AM Christoph Hellwig <hch@infradead.org>
>> wrote:
>>>
>>> please pull the dma-mapping updates for 5.4.
>>
>> Pulled.
>>
>>> In addition to the usual Kconfig conflics where you just want to keep
>>> both edits there are a few more interesting merge issues this time:
>>>
>>>  - most importanly powerpc and microblaze add new callers of
>>>    dma_atomic_pool_init, while this tree marks the function static
>>>    and calls it from a common postcore_initcall().  The trivial
>>>    functions added in powerpc and microblaze adding the calls
>>>    need to be removed for the code to compile.  This will not show up
>>>    as a merge conflict and needs to be dealt with manually!
>>
>> So I haven't gotten the powerpc or microblaze pull requests yet, so
>> I'm not able to fix that part up yet.
>>
>> Intead, I'm cc'ing Michael Ellerman and Michal Simek to ask them to
>> remind me when they _do_ send those pull requests, since otherwise I
>> may well forget and miss it. Without an actual data conflict, and
>> since this won't show up in my build tests either, it would be very
>> easy for me to forget.
>>
>> Micha[e]l, can you both please make sure to remind me?
> 
> Yeah I was aware of it, and will make sure to remind you in my pull request.

Same here.

Michal


-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

