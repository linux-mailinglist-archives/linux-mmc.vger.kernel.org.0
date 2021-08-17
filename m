Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB623EE194
	for <lists+linux-mmc@lfdr.de>; Tue, 17 Aug 2021 02:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236623AbhHQA4H (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 16 Aug 2021 20:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235974AbhHQAzy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Aug 2021 20:55:54 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E411C0613C1
        for <linux-mmc@vger.kernel.org>; Mon, 16 Aug 2021 17:55:20 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id i9so17306133lfg.10
        for <linux-mmc@vger.kernel.org>; Mon, 16 Aug 2021 17:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/8xXh4uAYLmC7B9Fj6XTx3aEzPEiY8DHDrOWM6RLdAY=;
        b=XT63hjpTOqal34rG4WIVTZFSl+hNwylMZJ6S2NC8YTo9uxqLGQKO6SvPZQBQbcNhjB
         u8LEZMD4oFHnetVUjrHH0NqAeNbv1CgPOo4zlrPobiGRBJX0qAQ11Oy2FqrT720M9934
         C+Vy4UecnQKRS6gyDDrnXlxbicjJxVLKtQyNqEGfxxcgcg9cr+UWCDGUrWFZq2bWUkuW
         x9bYMO+fSsZhwvzSDGTtzGG979snI6EXtQHYLXsiyQZgelrJQUvmGxST9h5uszdIilKj
         uKaaFsBEe/djtWOHnWt5p17myYUs0gmn6eOMOKlJaVb1XV0Ko6nxYbe3qpxrY/T3FgC5
         tYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/8xXh4uAYLmC7B9Fj6XTx3aEzPEiY8DHDrOWM6RLdAY=;
        b=Uz+Bio4b67mXlqk4LsXUxaPrHNjIMTawyNLvTRQLMwm+GSiI0jKYvfYYRSBW3DR+9O
         Nz4Ur4aS8KKPccs4nOFtgKBufIL8139/ynx7mOYmAvrOplOVsnB/A3CAjceqorIrxfU6
         i09u8vpqfhndK7g1BILGacAquwnGVEIE0JOZ5IAYR2wnd+7BgQIRvnjEWlvoPmWFyvhR
         o8SnQTPeXJI2CAt3uAk3L2NDACNUBUhnC+rWkicRYrhnpQxkRjfJ+2e8UfizvLxo/u6n
         pl02atvw4Jpap5guoWCiK60U87ofUoZvLbT2nzNr1gNsI3Im9mY3tSHGmdo0hI71uJ6T
         E3YA==
X-Gm-Message-State: AOAM531sAfiAHeUvlJHhzzJ5HaPpd0vRZLaJdWND1tRQimGvc9ZQQRNc
        Rt4PP20ZKcige7PLXbKAz8vbYA==
X-Google-Smtp-Source: ABdhPJyZ0zGdRSpfLJNcqsKT1e5xL6W6PntlPXhz2BykpLrQMBmSIjUKGP66GrGiWhrsFuR+5YQ2RA==
X-Received: by 2002:a05:6512:3041:: with SMTP id b1mr414095lfb.122.1629161719017;
        Mon, 16 Aug 2021 17:55:19 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id z6sm40719lfb.251.2021.08.16.17.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 17:55:18 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [RFC PATCH 07/15] Bluetooth: hci_qca: merge qca_power_on with qca_regulators_init
Date:   Tue, 17 Aug 2021 03:54:59 +0300
Message-Id: <20210817005507.1507580-8-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210817005507.1507580-1-dmitry.baryshkov@linaro.org>
References: <20210817005507.1507580-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

With wcn6750 support added, regulator-based code was extended with the
bt_en gpio support. Now there is no need to keep regulator and
non-regulator code paths separate. Merge both code paths.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/bluetooth/hci_qca.c | 64 ++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 40 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 279b802f0952..ad7e8cdc94f3 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1583,13 +1583,21 @@ static bool qca_prevent_wake(struct hci_dev *hdev)
 	return !wakeup;
 }
 
-static int qca_regulator_init(struct hci_uart *hu)
+static int qca_power_on(struct hci_dev *hdev)
 {
+	struct hci_uart *hu = hci_get_drvdata(hdev);
 	enum qca_btsoc_type soc_type = qca_soc_type(hu);
 	struct qca_serdev *qcadev;
+	struct qca_data *qca = hu->priv;
 	int ret;
 	bool sw_ctrl_state;
 
+	/* Non-serdev device usually is powered by external power
+	 * and don't need additional action in driver for power on
+	 */
+	if (!hu->serdev)
+		return 0;
+
 	/* Check for vregs status, may be hci down has turned
 	 * off the voltage regulator.
 	 */
@@ -1607,27 +1615,29 @@ static int qca_regulator_init(struct hci_uart *hu)
 		}
 	}
 
-	if (qca_is_wcn399x(soc_type)) {
-		/* Forcefully enable wcn399x to enter in to boot mode. */
-		host_set_baudrate(hu, 2400);
-		ret = qca_send_power_pulse(hu, false);
-		if (ret)
-			return ret;
-	}
-
 	/* For wcn6750 need to enable gpio bt_en */
 	if (qcadev->bt_en) {
 		gpiod_set_value_cansleep(qcadev->bt_en, 0);
 		msleep(50);
 		gpiod_set_value_cansleep(qcadev->bt_en, 1);
-		msleep(50);
+		msleep(150);
 		if (qcadev->sw_ctrl) {
 			sw_ctrl_state = gpiod_get_value_cansleep(qcadev->sw_ctrl);
 			bt_dev_dbg(hu->hdev, "SW_CTRL is %d", sw_ctrl_state);
 		}
 	}
 
-	qca_set_speed(hu, QCA_INIT_SPEED);
+	if (qca_is_wcn399x(soc_type)) {
+		/* Forcefully enable wcn399x to enter in to boot mode. */
+		host_set_baudrate(hu, 2400);
+		ret = qca_send_power_pulse(hu, false);
+		if (ret)
+			return ret;
+	}
+
+	if (qca_is_wcn399x(soc_type) ||
+	    qca_is_wcn6750(soc_type))
+		qca_set_speed(hu, QCA_INIT_SPEED);
 
 	if (qca_is_wcn399x(soc_type)) {
 		ret = qca_send_power_pulse(hu, true);
@@ -1647,38 +1657,12 @@ static int qca_regulator_init(struct hci_uart *hu)
 		return ret;
 	}
 
-	hci_uart_set_flow_control(hu, false);
-
-	return 0;
-}
-
-static int qca_power_on(struct hci_dev *hdev)
-{
-	struct hci_uart *hu = hci_get_drvdata(hdev);
-	enum qca_btsoc_type soc_type = qca_soc_type(hu);
-	struct qca_serdev *qcadev;
-	struct qca_data *qca = hu->priv;
-	int ret = 0;
-
-	/* Non-serdev device usually is powered by external power
-	 * and don't need additional action in driver for power on
-	 */
-	if (!hu->serdev)
-		return 0;
-
 	if (qca_is_wcn399x(soc_type) ||
-	    qca_is_wcn6750(soc_type)) {
-		ret = qca_regulator_init(hu);
-	} else {
-		qcadev = serdev_device_get_drvdata(hu->serdev);
-		if (qcadev->bt_en) {
-			gpiod_set_value_cansleep(qcadev->bt_en, 1);
-			/* Controller needs time to bootup. */
-			msleep(150);
-		}
-	}
+	    qca_is_wcn6750(soc_type))
+		hci_uart_set_flow_control(hu, false);
 
 	clear_bit(QCA_BT_OFF, &qca->flags);
+
 	return ret;
 }
 
-- 
2.30.2

