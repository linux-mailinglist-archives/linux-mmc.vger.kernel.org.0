Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B9A5A0A73
	for <lists+linux-mmc@lfdr.de>; Thu, 25 Aug 2022 09:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235518AbiHYHkR (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 25 Aug 2022 03:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235827AbiHYHkO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Aug 2022 03:40:14 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A039AFC1
        for <linux-mmc@vger.kernel.org>; Thu, 25 Aug 2022 00:40:12 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 2so16947998edx.2
        for <linux-mmc@vger.kernel.org>; Thu, 25 Aug 2022 00:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=nLgYgBZv4Ojie5IT52w9APyhpkfyBxlvpeMEG5br3b0=;
        b=hF1cSyp6RBBohDv1oesTIwpASQmIxKugq5RMW42oRcRIAVIXXBjJuORElZ/e6LjSvd
         S6CeZdGjW5Fsn6YJLgLeeNyLZyhHNcClYrR7zB5R1DsZRacS07FublchEh6HbR66NTLG
         zPE6Sjr/z4NE/LI7/ayRjT0m/wuw4kvQt7Qgs0RKgqkej1pjaAyjnYI8CKDxbZZfxGsh
         +zuRMNYvsqtt6mMouk1GyXT0/s6iUm9uu45jMXgZLl7DoG+M/05tKptMmV9HTEQN7xD7
         Zz4PjaOrfMpSQpCMWedGTT7hXcqQ+L0Ws8ymHcD6ZMfP8+QMY5nbZPxkq5djxTyDkfIc
         fQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=nLgYgBZv4Ojie5IT52w9APyhpkfyBxlvpeMEG5br3b0=;
        b=xyejziQrbYaUA8nsgpqeFo8UP0c0fjYYjA2lNTu2FuaULAMgn161JmOm5ikGYB1g8/
         a9Bu0Rq+qnJKEVBc0ZTtK9ykTtIrQdB7vELchi6eqwMAuRnDeTxjChKcNQ/k0n6pVjMG
         wB2UrJdnrHveUviWMn1cx9cutlrZCRJKBHOr04vIEqeh6QZqcewyXnLxZk6Zqfs+FoFw
         WPmtbzY9TkrzCzBvhoeezMbbjnGJYDtGTSSJT+NpVe9IMe78UTo7ioZpoVizVGqjp6yq
         gytUaEUpQEJRkq7iHKdwxXkyu/CvyftNRysAADIEkPI6xcDP0hy92bewg5tkI0Rl2m1q
         u3NA==
X-Gm-Message-State: ACgBeo0IJZhEj7+rPsPrh0J1kMXHzlqMhfWseEQx+W/wqyKQ+8fo3PSq
        nLybzyMwLqC8snEtDkoLFWmjBGLKB3ndl1WX
X-Google-Smtp-Source: AA6agR6iWaAWt83JulaknQIPGkAB7ve4B5dEcbKVHbYqeNKuexjnXc7bp0LJkYtV/6k+3iyIKmGBIg==
X-Received: by 2002:a05:6402:450c:b0:443:6279:774f with SMTP id ez12-20020a056402450c00b004436279774fmr2103576edb.11.1661413211451;
        Thu, 25 Aug 2022 00:40:11 -0700 (PDT)
Received: from lb02065.fritz.box ([2001:9e8:142d:a900:eab:b5b1:a064:1d0d])
        by smtp.gmail.com with ESMTPSA id jg31-20020a170907971f00b0072b3406e9c2sm2106267ejc.95.2022.08.25.00.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 00:40:10 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mmc: jz4740_mmc: Fix error check for dma_map_sg
Date:   Thu, 25 Aug 2022 09:40:08 +0200
Message-Id: <20220825074008.33349-3-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220825074008.33349-1-jinpu.wang@ionos.com>
References: <20220825074008.33349-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

dma_map_sg return 0 on error.

Cc: Paul Cercueil <paul@crapouillou.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mips@vger.kernel.org
Cc: linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/mmc/host/jz4740_mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index b1d563b2ed1b..dc2db9c185ea 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -298,7 +298,7 @@ static int jz4740_mmc_prepare_dma_data(struct jz4740_mmc_host *host,
 {
 	struct dma_chan *chan = jz4740_mmc_get_dma_chan(host, data);
 	enum dma_data_direction dir = mmc_get_dma_dir(data);
-	int sg_count;
+	unsigned int sg_count;
 
 	if (data->host_cookie == COOKIE_PREMAPPED)
 		return data->sg_count;
@@ -308,7 +308,7 @@ static int jz4740_mmc_prepare_dma_data(struct jz4740_mmc_host *host,
 			data->sg_len,
 			dir);
 
-	if (sg_count <= 0) {
+	if (!sg_count) {
 		dev_err(mmc_dev(host->mmc),
 			"Failed to map scatterlist for DMA operation\n");
 		return -EINVAL;
-- 
2.34.1

