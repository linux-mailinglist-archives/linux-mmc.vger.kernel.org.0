Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA0C7227C6
	for <lists+linux-mmc@lfdr.de>; Mon,  5 Jun 2023 15:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbjFENqV (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 5 Jun 2023 09:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbjFENqU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Jun 2023 09:46:20 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E37FA
        for <linux-mmc@vger.kernel.org>; Mon,  5 Jun 2023 06:46:15 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f7e7fc9fe6so1857925e9.3
        for <linux-mmc@vger.kernel.org>; Mon, 05 Jun 2023 06:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1685972773; x=1688564773;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rYKK5WNMfEjOGjyNV4BV3FvblimxrGOB2o0YYjGZMoc=;
        b=o14Lr3M7upHuE04It/xjCa/cGiFZydRy2hUwTK9XlH2YrDGpqVeV30TZrLGhiki0vJ
         yGrI8dACugq0IEvTWfhms4gs7Y+7zu3vZuYNML6zZKk9F4bMY1ZYjnJfxp15iqvO1Ast
         /pH9IYZGG2eW6ljMvGK8/1MjKS9hMqGeKd9dXX8BiPb30VjeWHO4EAaZd64KNX18Hvzi
         FL5jPdrgXYRRrkoAWgL7GFtjIbkZ8b6w3kqgu+LvsMoOM+s3VtjAEYaGM8ALMdzdy+e9
         lYSsqb4b83Eo6wG8Y/ladavWs1TvECsSxmVly/haTUzpQuFU/8bP1AtRUMoIHunMjAOl
         kmcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685972773; x=1688564773;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rYKK5WNMfEjOGjyNV4BV3FvblimxrGOB2o0YYjGZMoc=;
        b=bA4rCkqJe4TQgi+CBDcGoU71BdjZVHBcUR6DYDeu8q+ayvYWmNuA4BOg0O/KDbbYRx
         j5Qg3eDyGsUEhe/rcb3VHcgrOLPGXBUnvN3JkXITJLLXAYJ2gv3KZaIWb7+ZLnQGDngQ
         xvccTi/5SxDVSDmkcgu3KO2wfazKcih/PJt2X9Ntt8G9oDePKwViYx8wBJk8TaTvYq1p
         r91fc7b0Z7ylTmS/yCJ/56Lkh2ibFqNV/VgqnWnUTszaa0XGmpufwfpoXyPVnvZ/X7or
         88zB8BIa2QXFotFXM/b06Xzs5ZQdAwvsEg2qvMdDd5XblwIywGBc7wZhowTUmYSJl1nx
         r1lw==
X-Gm-Message-State: AC+VfDz3n7wPrqHfUN3ZxMXQ57SFAbUvH1RpgP3IZ86qzWrqN1EMlEGH
        ZAbuoAxDYRu5NOSLbWhD3jGUBg==
X-Google-Smtp-Source: ACHHUZ6pe5WzdC0oeZHm5ttRdAIOIatHBO9NbMz+Wi/TXtcIHPM0H3CJ2RQWxyznNcTYqcUoUr/Bgg==
X-Received: by 2002:a1c:f70a:0:b0:3f6:da2:bc86 with SMTP id v10-20020a1cf70a000000b003f60da2bc86mr7668207wmh.7.1685972773675;
        Mon, 05 Jun 2023 06:46:13 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id c11-20020a05600c0acb00b003f72d7dc66esm7682965wmr.13.2023.06.05.06.46.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 06:46:13 -0700 (PDT)
Message-ID: <0e7cc4cf-68da-207d-03b5-f9bd065f7940@baylibre.com>
Date:   Mon, 5 Jun 2023 15:46:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4] mmc: mtk-sd: reduce CIT for better performance
Content-Language: en-US
To:     Wenbin Mei <wenbin.mei@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230605121442.23622-1-wenbin.mei@mediatek.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230605121442.23622-1-wenbin.mei@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 05/06/2023 14:14, Wenbin Mei wrote:
> CQHCI_SSC1 indicates to CQE the polling period to use when using periodic
> SEND_QUEUE_STATUS(CMD13) polling.
> Since MSDC CQE uses msdc_hclk as ITCFVAL, so driver should use hclk
> frequency to get the actual time.
> The default value 0x1000 that corresponds to 150us for MediaTek SoCs, let's
> decrease it to 0x40 that corresponds to 2.35us, which can improve the
> performance of some eMMC devices.

Hi,

- Can you add the version change log and the link to the previous
patch version (at least) please ?

- On which board(s) did you test this patch please ?

-- 
Regards,
Alexandre

