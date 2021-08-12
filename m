Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD41E3EA88D
	for <lists+linux-mmc@lfdr.de>; Thu, 12 Aug 2021 18:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbhHLQax (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 12 Aug 2021 12:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbhHLQax (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Aug 2021 12:30:53 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06ACC0613D9
        for <linux-mmc@vger.kernel.org>; Thu, 12 Aug 2021 09:30:27 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id t35so11204147oiw.9
        for <linux-mmc@vger.kernel.org>; Thu, 12 Aug 2021 09:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x4cHlQi/obhutO8LyeLFAXruEbBUWhCtJGxWE1s0N8U=;
        b=1rQ0mvustmtHXZ9U4L7gESxZbbqf2omo6y+0DkbXfIM5f7jDR1C54mTtLi+VBRe8Ri
         eKlcSaEDchw6I1SlloYW3zJh04HuTIYO+Q882Jty+7he4kk9+5qPwRsQsLOZVeMjMIsc
         oi3ti9jbeFQ7J/hgVkb0EM50yCmk+wxySBnupMJHBjAM0Bx5zUYk34ix6PG4vi9yZ7oa
         d48PgHNqKN03IFkifLYQ62bUSU7YhdJZ0I9vvA5ZLVJIw2JCm7DusCjxWeO87jlAh9zg
         oSC9fDh0NRkzMVe+Tlv05IDtO33QLAZpSejO9BUjaeTjO8bYFsIpetOwwMJGZLXPeFsA
         N4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x4cHlQi/obhutO8LyeLFAXruEbBUWhCtJGxWE1s0N8U=;
        b=TW62N3RxxO3WQ7QQpepdj0pHcjvC/hHpZO1liw3Va3xDoRAf2Ff35T45R4VXp1/+8J
         NHBkmMfqetOoMc6ehB20+HGOS6k/m96k4RIJbp9e9kKJEEkP7LgJnzTSfroNUKXArECP
         sxIGUNjfaGGAsn9NRsnCYL70HKBgD674BTFAdjh8NX/YLbkLTy7Vx/0NscducaCdi/8x
         dpAIzCB+EuhoLSwZY9sYpySnJkKQPAbDjt8Qsi8jSidHECs9r6+3alAvAb2MkNr1hqex
         4EvvNx5tRlfSBs1MDEWZ16BS9o4CeUjtPxWwulWF2Q3oMvME2Y/Z/WHCm/Rr3MQK2xCl
         /cZQ==
X-Gm-Message-State: AOAM531dugMsbj2T2TvWjgrlvpWuknL5giGowhYyjo0lLF66Wa4wfIDG
        I7Y4RhTdVDyFcqGwWA9KwZq74g==
X-Google-Smtp-Source: ABdhPJy2dkFA+KnUiS1sS6pKuw2wcOYGZn612cKtDfh2S9ahMGuS9i7oBMQNyXf3JaG+igFZLuxRCw==
X-Received: by 2002:aca:1c0a:: with SMTP id c10mr4010067oic.87.1628785827272;
        Thu, 12 Aug 2021 09:30:27 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id m9sm637634ooe.32.2021.08.12.09.30.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 09:30:26 -0700 (PDT)
Subject: Re: remove GENHD_FL_UP
To:     Christoph Hellwig <hch@lst.de>
Cc:     Coly Li <colyli@suse.de>, Song Liu <song@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20210809064028.1198327-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <477bcf09-1711-b643-85b2-e8f0809b6dda@kernel.dk>
Date:   Thu, 12 Aug 2021 10:30:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210809064028.1198327-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 8/9/21 12:40 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series first cleans up various drivers to not rely on the
> internal GENHD_FL_UP to decided if they need to call del_gendisk
> and then removes the flag entirely.

Applied, thanks.

-- 
Jens Axboe

