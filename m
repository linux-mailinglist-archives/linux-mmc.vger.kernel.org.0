Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1510A6516C9
	for <lists+linux-mmc@lfdr.de>; Tue, 20 Dec 2022 00:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbiLSXlL (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 19 Dec 2022 18:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbiLSXlL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Dec 2022 18:41:11 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6942AFCC0
        for <linux-mmc@vger.kernel.org>; Mon, 19 Dec 2022 15:41:05 -0800 (PST)
Received: from [10.0.0.226] (S010600cb7a0d6c8b.vs.shawcable.net [96.55.249.129])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0479D20C3320;
        Mon, 19 Dec 2022 15:41:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0479D20C3320
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1671493265;
        bh=bwqIzA8bX6ktnXRP4cX3zo/A4f11NapbtjSSik9kTKE=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=LQ9xUbIZx3iBJvMua4sSwl6XRojXluWKMZyAySVQ1kPh5YH7UccMYMywR/RCX+UD0
         RYPKkaCb0X3Y3o1SPBLE/PoY+ep8lEqTdcqU0vbIGUQW5Z8d3NPuVAf/yuSXhN1GXF
         FtTMqIbLL01HgMI2CrIO/BRdmsyo5E8tnAqW91z8=
Message-ID: <14de0095-db93-cf5b-e843-1554a392b177@linux.microsoft.com>
Date:   Mon, 19 Dec 2022 15:41:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] mmc: core: host: fix mmc retuning
Content-Language: en-US
From:   Shyam Saini <shyamsaini@linux.microsoft.com>
To:     linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, adrian.hunter@intel.com, code@tyhicks.com
References: <20221219225319.24637-1-shyamsaini@linux.microsoft.com>
In-Reply-To: <20221219225319.24637-1-shyamsaini@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-21.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi All,

Cc'ing Tyler

Please note that I am not 100 % sure about the fix.
This issue is reproducible without this patch and the patch at least fix 
the issue without
any regressions on our side.

We observed that hold_retune is always greater or equal to 1 in 
mmc_retune() function,

so it may always avoid  re-tuning when it is actually needed and there may

be a better fix for the issue.

Please let me know your any feedback or comments.

Best Regards,
Shyam


